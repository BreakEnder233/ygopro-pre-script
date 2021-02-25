--溟界的蛇睡莲

--Scripted by Lighty_The_Light
function c100416010.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetCountLimit(1,100416010)
	e1:SetTarget(c100416010.target)
	e1:SetOperation(c100416010.activate)
	c:RegisterEffect(e1)
end
function c100416010.tgfilter(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_REPTILE) and c:IsAbleToGrave()
end
function c100416010.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100416010.tgfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOGRAVE,nil,1,tp,LOCATION_DECK)
end
function c100416010.spfilter1(c)
	return c:IsType(TYPE_MONSTER) and c:IsRace(RACE_REPTILE)
end
function c100416010.spfilter2(c,e,tp)
	return c100416010.spfilter1(c) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100416010.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TOGRAVE)
	local g=Duel.SelectMatchingCard(tp,c100416010.tgfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()==0 then return end
	if Duel.SendtoGrave(g,REASON_EFFECT)==0 then return end

	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 then return false end

	local g=Duel.GetMatchingGroup(c100416010.spfilter1,tp,LOCATION_GRAVE,0,nil)
	local ct=g:GetClassCount(Card.GetCode)
	if ct<5 then return end
	
	if Duel.SelectYesNo(tp,aux.Stringid(100416010,0)) then
		local sg=Duel.SelectMatchingCard(tp,aux.NecroValleyFilter(c100416010.spfilter2),tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
		local tc=sg:GetFirst()
		Duel.BreakEffect()
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
		Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)
	end
end


