Content-Type: multipart/mixed; boundary="===============4773873815251195220=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH net-next] Squash-to: "mptcp: allow picking
 different xmit subflows"
Date: Mon, 14 Sep 2020 09:16:53 +0200
Message-ID: <de07f778-2516-a04d-e38d-b6fa032a1b9f@tessares.net>
In-Reply-To: 431667ae326bed92b325685cf1275ae2d6575e73.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 5830

--===============4773873815251195220==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo,

On 13/09/2020 12:12, Paolo Abeni wrote:
> On Fri, 2020-09-11 at 16:12 -0700, Mat Martineau wrote:
>> On Fri, 11 Sep 2020, Paolo Abeni wrote:
>>
>>> unbreak 32 bits build avoid unsing '/' on 64 bits arguments.
>>>
>>> Signed-off-by: Paolo Abeni <pabeni(a)redhat.com>
>>> ---
>>> net/mptcp/protocol.c | 6 ++++--
>>> 1 file changed, 4 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
>>> index e5ef7227c914..d848ade67a4a 100644
>>> --- a/net/mptcp/protocol.c
>>> +++ b/net/mptcp/protocol.c
>>> @@ -1082,8 +1082,9 @@ static struct sock *mptcp_subflow_get_send(struct=
 mptcp_sock *msk,
>>> 	struct subflow_send_info send_info[2];
>>> 	struct mptcp_subflow_context *subflow;
>>> 	int i, nr_active =3D 0;
>>> -	int64_t ratio, pace;
>>> 	struct sock *ssk;
>>> +	u64 ratio;
>>> +	u32 pace;
>>>
>>> 	sock_owned_by_me((struct sock *)msk);
>>>
>>> @@ -1128,7 +1129,8 @@ static struct sock *mptcp_subflow_get_send(struct=
 mptcp_sock *msk,
>>> 		if (!pace)
>>> 			continue;
>>>
>>> -		ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32 / pace;
>>> +		ratio =3D div_u64((u64)READ_ONCE(ssk->sk_wmem_queued) << 32,
>>> +				pace);
>>
>> For some reason this thread did not get to my inbox...
>>
>> I think you've also fixed an issue with operator precedence in this
>> expression. Given the div_u64 version of the expression, you intended
>> this:
>>
>> ratio =3D ((int64_t)READ_ONCE(ssk->sk_wmem_queued) << 32) / pace;
>>
>> to give you more significant digits than you would have had without
>> shifting sk_wmem_queued. However, the old expression in the v1 patch is
>> equivalent to:
>>
>> ratio =3D (int64_t)READ_ONCE(ssk->sk_wmem_queued) << (32 / pace);
>>
>> So, assuming pace is usually large this was shifting by 0 and selecting
>> the subflow with lower sk_wmem_queued. Behavior may be changed now
>> (hopefully for the better!), not sure if you want to do more testing
>> before posting v2.
> =

> wow, the old version was incredibly buggy!!! :(((
> =

> Thank you very much for catching the above!
> =

> The new behaviour is the indended one since the beginning. I tested the
> thing in a tight loop since Fri evening. I'd like to post, to move this
> over.
> =

> Anyway I'll wait Mon morning my time, to get more feedback from CI, and
> hopefully get feedback from Eric/Dave when they will wake-up

On my side, my CI is good with the new version.
Note that my CI is also validating i386 build but kbuild reported issues =

only with m68k.

I don't know how to check if kbuild validated the commit but I guess it =

did it. Last time it took ~6h15 after the update of the export branch to =

report the issue.

Happy sending then :)

Cheers,
Matt
-- =

Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--===============4773873815251195220==--
