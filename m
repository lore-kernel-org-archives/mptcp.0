Content-Type: multipart/mixed; boundary="===============8564022776527896230=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH] Squash-to: "sock: Make sk_protocol a 16-bit value"
Date: Tue, 07 Jan 2020 09:24:52 -0800
Message-ID: <alpine.OSX.2.21.2001070917410.15534@fepiepan-mobl.amr.corp.intel.com>
In-Reply-To: 7f00d4b859864ba6a5064b9ce58bb7179e755c71.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3262

--===============8564022776527896230==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 7 Jan 2020, Paolo Abeni wrote:

> On Tue, 2020-01-07 at 16:08 +0100, Matthieu Baerts wrote:
>> Hi Paolo,
>>
>> On 07/01/2020 15:05, Paolo Abeni wrote:
>>> We need to update the ebpf accessors for both sk_type and
>>> sk_protocol. The code previously in place has some special
>>> hack to take care such fields being part of a bitfield.
>>>
>>> The fix actually clean-up a bit the existing code.
>>
>> Thank you for looking at that!
>>
>> I have 3 questions below.
>>
>>> Note: I'm not 100% sure about dropping the 'target_size' handling.
>>> This changes the 'target_size' from 1 to 2 for sk_protocol.
>>> Should not matter, as the ebpf target field is 4 bytes wide.

It looks like your handling of target_size is consistent with other 16-bit =

fields (like skc_dport), so it seems like the right way to go.

>>>
>>> To be appended to the orig commit message:
>>> """
>>> Take care of BPF field access for sk_type/sk_protocol.
>>> Both of them are now outside the bitfield, so we can use
>>> load instructions without fourther shifting/masking.
>>
>> (detail: s/fourther/further)
>>
>>> v5 -> v6:
>>>   - update eBPF accessors, too.
>>> """
>>>
>>> Additionally, Eric's Reviewed-by should be dropped.
>>
>> Good point!
>>
>>> ---
>>>   include/net/sock.h | 15 ------------
>>>   net/core/filter.c  | 58 ++++++++++++++++------------------------------
>>>   2 files changed, 20 insertions(+), 53 deletions(-)
>>>

...

>
> I'll send v1 with the cleanup hinted by the 2nd question after doing
> some tests.
>

I don't have anything to add to Matthieu's comments for now, and thanks =

for tracking this down Paolo! Will watch for next version.

--
Mat Martineau
Intel
--===============8564022776527896230==--
