Content-Type: multipart/mixed; boundary="===============2513153986315447580=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH mptcp-next] Squash to "mptcp: only admit
 explicitly supported sockopt"
Date: Thu, 11 Mar 2021 12:05:00 +0100
Message-ID: <caf870f2-80b4-87b3-217d-6567508f11da@tessares.net>
In-Reply-To: 246241bfed0aa8cc775699c530786ad813e10c97.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 8099

--===============2513153986315447580==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 11/03/2021 11:43, Paolo Abeni wrote:
> On Thu, 2021-03-11 at 11:11 +0100, Matthieu Baerts wrote:
>> SO_SNDTIMEO_{OLD,NEW} were missing in the list. They are considered as
>> "quite common but need a better implementation".
>>
>> Indeed, as mentioned by Paolo: these settings are applied only to the
>> first subflow, while mptcp_recvmsg()/mptcp_sendmsg() will look for the
>> timeout value in the msk socket.
>>
>> At least with these patches, we can have MPTCP BPF selftest passing:
>>
>>    ./test_progs -n 66
>>
>> Reported-and-tested-by: Geliang Tang <geliangtang(a)gmail.com>
>> Signed-off-by: Matthieu Baerts <matthieu.baerts(a)tessares.net>
>> ---
>>
>> Notes:
>>      to be squashed in "mptcp: only admit explicitly supported sockopt"
>>
>>   net/mptcp/sockopt.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/net/mptcp/sockopt.c b/net/mptcp/sockopt.c
>> index 3eda9127debb..fb98fab252df 100644
>> --- a/net/mptcp/sockopt.c
>> +++ b/net/mptcp/sockopt.c
>> @@ -110,6 +110,8 @@ static bool mptcp_supported_sockopt(int level, int o=
ptname)
>>   		case SO_RCVLOWAT:
>>   		case SO_RCVTIMEO_OLD:
>>   		case SO_RCVTIMEO_NEW:
>> +		case SO_SNDTIMEO_OLD:
>> +		case SO_SNDTIMEO_NEW:
>>   		case SO_MARK:
>>   		case SO_INCOMING_CPU:
>>   		case SO_BINDTOIFINDEX:
> =

> LGTM!



Thank you for the review!

- 2b1cba1c2163: "squashed" in "mptcp: only admit explicitly supported =

sockopt"
- 9d7b32e1e6c7: "Signed-off-by" + "Co-developed-by" auto-added (doesn't =

feel right compared to all the work you did, I'm not sure I should keep =

that)
- Results: b75b267765e6..d92688622965

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============2513153986315447580==--
