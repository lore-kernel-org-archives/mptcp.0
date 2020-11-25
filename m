Content-Type: multipart/mixed; boundary="===============3050236770334703964=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [MPTCP][PATCH v6 mptcp-next 8/9] mptcp: add the mibs for
 ADD_ADDR with port
Date: Wed, 25 Nov 2020 11:31:48 +0100
Message-ID: <4d94e1a6-d54a-04c5-d738-8f25716ab566@tessares.net>
In-Reply-To: f58890ee973debd06bdc7b823c5be75249641974.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 6926

--===============3050236770334703964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 25/11/2020 11:03, Paolo Abeni wrote:
> On Wed, 2020-11-25 at 11:01 +0800, Geliang Tang wrote:
>> This patch added the mibs for ADD_ADDR with port:
>>
>> MPTCP_MIB_PORTADD for receiving of the ADD_ADDR suboption with a port
>> number. MPTCP_MIB_PORTSYNRX, MPTCP_MIB_PORTSYNACKRX, MPTCP_MIB_PORTACKRX,
>> for receiving of the MP_JOIN's SYN or SYN/ACK or ACK with a port number
>> which is different from the msk's port number.
>>
>> Signed-off-by: Geliang Tang <geliangtang(a)gmail.com>
>> ---

(...)

>> diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
>> index cb72327c006a..6193e53d4af1 100644
>> --- a/net/mptcp/subflow.c
>> +++ b/net/mptcp/subflow.c
>> @@ -196,6 +196,7 @@ static void subflow_init_req(struct request_sock *re=
q,
>>   				subflow_req->mp_join =3D 0;
> =

> We likely want to increment some 'bad port' MIB counter in case of
> mismatch.
> =

> @Christoph: looks like mptcp.org does not have MIBs for these things,
> any plan to add them? any suggestions on relevant names/things to
> track?


In mptcp.org, we have one MIB counter related to MP_JOIN on a different =

port: MPTCP_MIB_JOINALTERNATEPORT

   https://github.com/multipath-tcp/mptcp/commit/b53ad83908483f28f608b

I don't think any PMs in mptcp.org announce an address with a different =

port but we have "ndiffport" that sends MP_JOIN to a different port. It =

works because we accept MP_JOIN sent to any port (hack).

I think it is not a bad thing to have these new counters :)
But maybe we should prefix the PORTSYN/SYNACK/ACK ones with JOIN? (e.g. =

MPTCP_MIB_JOINPORTSYNRX and MPJoinPortSynRx ; or with "Port" at the end)
It is still an MP_JOIN we receive but to a different port.

Do you mean we might not need them?

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============3050236770334703964==--
