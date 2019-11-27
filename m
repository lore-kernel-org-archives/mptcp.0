Content-Type: multipart/mixed; boundary="===============4811821832909633962=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH MPTCP] init ssn_offset for incoming/outgoing join
 requests
Date: Wed, 27 Nov 2019 19:08:18 +0100
Message-ID: <808c4962-6b81-065c-d10a-530d8b98e73e@tessares.net>
In-Reply-To: ce898106cb828295fc72f9af63249f69e46a5589.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 2703

--===============4811821832909633962==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Florian, Paolo,

On 27/11/2019 16:37, Paolo Abeni wrote:
> On Wed, 2019-11-27 at 13:18 +0100, Florian Westphal wrote:
>> squashto: mptcp: Add handling of outgoing MP_JOIN requests
>>
>> Signed-off-by: Florian Westphal <fw(a)strlen.de>
>> ---
>>   net/mptcp/subflow.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index ba46c0b3a6d7..45ceb9a955a8 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -139,6 +139,7 @@ static void subflow_init_req(struct request_sock *re=
q,
>>   		subflow_req->remote_key =3D rx_opt.mptcp.sndr_key;
>>   		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
>>   	} else if (rx_opt.mptcp.mp_join && listener->request_mptcp) {
>> +		subflow_req->ssn_offset =3D TCP_SKB_CB(skb)->seq;
>>   		subflow_req->mp_join =3D 1;
>>   		subflow_req->backup =3D rx_opt.mptcp.backup;
>>   		subflow_req->remote_id =3D rx_opt.mptcp.join_id;
>> @@ -231,6 +232,8 @@ static void subflow_finish_connect(struct sock *sk, =
const struct sk_buff *skb)
>>   				      subflow->remote_nonce,
>>   				      (u32 *)subflow->hmac);
>>   =

>> +		if (skb)
>> +			subflow->ssn_offset =3D TCP_SKB_CB(skb)->seq;
>>   		mptcp_finish_join(sk);
>>   		subflow->conn_finished =3D 1;
>>   	}
>> @@ -885,6 +888,7 @@ static void subflow_ulp_clone(const struct request_s=
ock *req,
>>   		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
>>   		new_ctx->idsn =3D subflow_req->idsn;
>>   	} else if (subflow_req->mp_join) {
>> +		new_ctx->ssn_offset =3D subflow_req->ssn_offset;
>>   		new_ctx->mp_join =3D 1;
>>   		new_ctx->fourth_ack =3D 1;
>>   		new_ctx->backup =3D subflow_req->backup;
> =

> LGTM!

Thank you for the patch and the review!

- d950276fff5d: "squashed" in "mptcp: Add handling of outgoing MP_JOIN =

requests"
- 9503bde4eead..4bd50dcab84a: result

Tests are still OK!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============4811821832909633962==--
