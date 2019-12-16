Content-Type: multipart/mixed; boundary="===============7116247211416172517=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Mon, 16 Dec 2019 19:29:57 +0100
Message-ID: <13651369-c87c-4e81-4fa9-8c8ac6ab6db3@tessares.net>
In-Reply-To: 338c1468cc8a8b6be920804b13f5f9568937554f.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3087

--===============7116247211416172517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 16/12/2019 18:47, Paolo Abeni wrote:
> On Mon, 2019-12-16 at 08:51 -0800, Mat Martineau wrote:
>> On Mon, 16 Dec 2019, Paolo Abeni wrote:
>>
>>> move sk_pacing_shift to a separate field, so we can READ_ONCE() it.
>>>
>>> Binary layout of struct sock dose not change (except for the
>>> sk_pacing_shift position)
>>> ---
>>> This addresses Eric's upstream feedback on v1
>>> ---
>>> include/net/sock.h | 2 +-
>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/include/net/sock.h b/include/net/sock.h
>>> index 9dd225f62012..0930f46c600c 100644
>>> --- a/include/net/sock.h
>>> +++ b/include/net/sock.h
>>> @@ -456,8 +456,8 @@ struct sock {
>>> 				sk_no_check_tx : 1,
>>> 				sk_no_check_rx : 1,
>>> 				sk_userlocks : 4,
>>> -				sk_pacing_shift : 8,
>>> 				sk_type      : 16;
>>> +	u8			sk_pacing_shift;
>>> 	u16			sk_protocol;
>>> 	u16			sk_gso_max_segs;
>>
>> sk_pacing_shift was here (between sk_gso_max_segs and sk_lingertime)
>> before, would be good to put it back where it was for a clean diff.
> =

> But we can't move back there, otherwise the 'struct sock' will grow
> quite a bit (we will have 7 bytes hole on 64 bits arch).
> =

> With the proposed patch 'struct sock' size does not change.

- 548181045475: "squashed" in "sock: Make sk_protocol a 16-bit value"
- 4d09491bafaf: "Signed-off-by" + "Co-developed-by"
- 66880827b48f..e999bb17232e: result

Tests + export will be launched soon.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============7116247211416172517==--
