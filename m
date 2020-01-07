Content-Type: multipart/mixed; boundary="===============5178502793559279394=="
MIME-Version: 1.0
From: Matthieu Baerts <matthieu.baerts at tessares.net>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "sock: Make sk_protocol a 16-bit
 value"
Date: Tue, 07 Jan 2020 23:21:08 +0100
Message-ID: <59491a5f-e3da-189b-dc08-90c4411d78d7@tessares.net>
In-Reply-To: 3c338f9b353da739e72c3c7bb2a290074ea38c85.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3269

--===============5178502793559279394==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Paolo, Mat,

On 07/01/2020 19:13, Paolo Abeni wrote:
> On Tue, 2020-01-07 at 10:05 -0800, Mat Martineau wrote:
>> On Tue, 7 Jan 2020, Mat Martineau wrote:
>>
>>> On Tue, 7 Jan 2020, Paolo Abeni wrote:
>>>
>>>> We need to update the ebpf accessors for both sk_type and
>>>> sk_protocol. The code previously in place has some special
>>>> hack to take care such fields being part of a bitfield.
>>>>
>>>> The fix actually clean-up a bit the existing code.
>>>>
>>>> Note: I'm not 100% sure about dropping the '*target_size =3D '
>>>> instructions, my take is that the full ebpf register is loaded
>>>> with the (short) values. AFAICS other short field accesses
>>>> do not set 'targer_size', too.
>>>>
>>>> to be appended to the orig commit message:
>>>> """
>>>> Take care of BPF field access for sk_type/sk_protocol.
>>>> Both of them are now outside the bitfield, so we can use
>>>> load instructions without further shifting/masking.
>>>>
>>>> v5 -> v6:
>>>> - update eBPF accessors, too.
>>>> """
>>>>
>>>> Additionally, Eric's Reviewed-by should be dropped.
>>>>
>>>> v1 -> v2:
>>>> - replace BPF_H with BPF_FIELD_SIZEOF, plus indentation
>>>>    adjust (matttbe)
>>>
>>> Based on code review and applying/building the patch, I think it this i=
s good
>>> to merge/squash.
>>>
>>> I'm still working on getting the relevant ebpf selftest to run locally =
and
>>> would like to replicate Paolo's results before sending v6. If any fixes=
 are
>>> required we can squash those too.
>>>
>>
>> One more thing - should we cc the BPF maintainer(s) on this patch when
>> submitting to netdev?
> =

> Both Alexei and Daniel are subscribed to netdev, but I think likely the
> patch will go unnoticed for them unless we cc them explicitly. Yep, cc-
> ing them should be good, IMHO.

- 80133b5cafce: "squashed" in "sock: Make sk_protocol a 16-bit value"
- 73b0b8fd39c7: tg:msg: remove Eric's Reviewed-by
- a4fca1719469: tg:msg: add Paolo's changelog
- e7785eab3ede: tg:msg: add BPF maintainers + ML in Cc

Tests are in progress.

Cheers,
Matt
-- =

Matthieu Baerts | R&D Engineer
matthieu.baerts(a)tessares.net
Tessares SA | Hybrid Access Solutions
www.tessares.net
1 Avenue Jean Monnet, 1348 Louvain-la-Neuve, Belgium
--===============5178502793559279394==--
