--大いなる魔導

--Scripted by mallu11
function c100415010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetHintTiming(0,TIMINGS_CHECK_MONSTER+TIMING_END_PHASE)
	e1:SetCountLimit(1,100415010+EFFECT_COUNT_CODE_OATH)
	e1:SetTarget(c100415010.target)
	e1:SetOperation(c100415010.activate)
	c:RegisterEffect(e1)
end
function c100415010.filter(c,tp,check)
	return c:IsFaceup() and c:IsSetCard(0x251) and Duel.IsExistingMatchingCard(c100415010.eqfilter,tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE,0,1,c,check)
end
function c100415010.eqfilter(c,check)
	return (c:IsFaceup() or not c:IsLocation(LOCATION_MZONE)) and c:IsSetCard(0x251) and c:IsType(TYPE_MONSTER) and not c:IsLevel(4) or check and c:IsLocation(LOCATION_EXTRA) and not c:IsSetCard(0x251) and c:IsType(TYPE_FUSION+TYPE_SYNCHRO+TYPE_XYZ+TYPE_LINK)
end
function c100415010.gfilter(c,type)
	return c:IsSetCard(0x251) and c:IsType(type)
end
function c100415010.chkfilter(tp,type)
	return Duel.IsExistingMatchingCard(c100415010.gfilter,tp,LOCATION_GRAVE,0,1,nil,type)
end
function c100415010.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local check=c100415010.chkfilter(tp,TYPE_FUSION) and c100415010.chkfilter(tp,TYPE_SYNCHRO) and c100415010.chkfilter(tp,TYPE_XYZ) and c100415010.chkfilter(tp,TYPE_LINK)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100415010.filter(chkc,tp,check) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(c100415010.filter,tp,LOCATION_MZONE,0,1,nil,tp,check) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100415010.filter,tp,LOCATION_MZONE,0,1,1,nil,tp,check)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,1,tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE)
end
function c100415010.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and Duel.GetLocationCount(tp,LOCATION_SZONE)>0 then
		local check=c100415010.chkfilter(tp,TYPE_FUSION) and c100415010.chkfilter(tp,TYPE_SYNCHRO) and c100415010.chkfilter(tp,TYPE_XYZ) and c100415010.chkfilter(tp,TYPE_LINK)
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
		local g=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100415010.eqfilter),tp,LOCATION_EXTRA+LOCATION_MZONE+LOCATION_GRAVE,0,1,1,c,check)
		local ec=g:GetFirst()
		if ec then
			if not Duel.Equip(tp,ec,tc) then return end
			--equip limit
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e1:SetLabelObject(tc)
			e1:SetValue(c100415010.eqlimit)
			e1:SetReset(RESET_EVENT+RESETS_STANDARD)
			ec:RegisterEffect(e1)
		end
	end
end
function c100415010.eqlimit(e,c)
	return c==e:GetLabelObject()
end