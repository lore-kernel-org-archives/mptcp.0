Content-Type: multipart/mixed; boundary="===============5963735448848074734=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] mptcp: Remove all traces of checksum support
Date: Wed, 02 Oct 2019 11:33:56 +0200
Message-ID: <c1ea0ccb-aa7f-24de-8903-be2f6218300d@tessares.net>
In-Reply-To: 6fa56a27-10f0-fe52-fde2-2a2472780e4c@tessares.net
X-Status: 
X-Keywords:                  
X-UID: 1981

--===============5963735448848074734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Peter,

On 01/10/2019 14:14, Matthieu Baerts wrote:
> Hi Paolo, Peter,
> =

> On 30/09/2019 16:08, Paolo Abeni wrote:
>> Hi,
>>
>> On Wed, 2019-09-25 at 16:44 -0700, Peter Krystad wrote:
>>> diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
>>> index f1f5ab3990ab..400fbb0060f3 100644
>>> --- a/net/mptcp/protocol.h
>>> +++ b/net/mptcp/protocol.h
>>> @@ -173,7 +173,7 @@ struct subflow_request_sock {
>>>  	struct	tcp_request_sock sk;
>>>  	u8	mp_capable : 1,
>>>  		mp_join : 1,
>>> -		checksum : 1,
>>> +		unused : 1,
>>>  		backup : 1,
>>>  		version : 4;
>>>  	u8	local_id;
>>
>> Sorry I did not notice this beforehand. It looks a little strange to me
>> creating a new struct with some 'unused' field. But I think is not
>> blocking: we can merge the patch as-is and ev. drop the field later -
>> if there is agreement on that.
> =

> I agree that it is certainly better to remove it in this context.

I hope you don't mind if I remove this "unused" field when applying your
patch. I had to apply this bit manually anyway and I guess if we need an
"unused" field, it would be better at the end.

I can of course still change that again later if needed!

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5963735448848074734==--
