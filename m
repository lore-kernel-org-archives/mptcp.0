Content-Type: multipart/mixed; boundary="===============4055352011486510818=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: BPF-related self test failure with part1-v5 patches
Date: Tue, 07 Jan 2020 15:49:15 -0800
Message-ID: <alpine.OSX.2.21.2001071547480.18884@fepiepan-mobl.amr.corp.intel.com>
In-Reply-To: 99c5be4c85f3f33730b3bd94d27b000e1c8d4006.camel@redhat.com
X-Status: 
X-Keywords:                  
X-UID: 3270

--===============4055352011486510818==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Jan 2020, Paolo Abeni wrote:

> On Tue, 2020-01-07 at 09:38 -0800, Mat Martineau wrote:
>> On Tue, 7 Jan 2020, Paolo Abeni wrote:
>>
>>> On Mon, 2020-01-06 at 15:05 -0800, Mat Martineau wrote:
>>>> Hello everyone -
>>>>
>>>>
>>>> I received a 0day automated build email this morning related to patch =
2/11
>>>> in our v5 patch set:
>>>>
>>>> https://lists.01.org/hyperkitty/list/lkp(a)lists.01.org/thread/XB3HTAB=
NGVKPJ5QEF46NLIYN6AN5DNGD/
>>>>
>>>> In summary, there's a test failure in the BPF self tests:
>>>>
>>>> """
>>>> # selftests: bpf: test_select_reuseport
>>>> ...
>>>> # ######## IPv6/TCP LOOPBACK ########
>>>> # test_err_inner_map: unexpected result
>>>> # result: [0, 0, 0, 1, 0, 0]
>>>> # expected: [1, 0, 0, 0, 0, 0]
>>>> # check_results(343):FAIL:unexpected result expected_results[0] !=3D r=
esults[0]
>>>> bpf_prog_linum:142
>>>> not ok 17 selftests: bpf: test_select_reuseport # exit=3D255
>>>> """
>>>>
>>>> It seems like a good idea to see if this is reproducible before sending
>>>> v6, for a few reasons:
>>>
>>> +1
>>>
>>>> I run in to build problems, though - it looks like LLVM 10 is required=
 to
>>>> build the BPF tests, is anyone already set up with that version?
>>>
>>> I'm unsure if such version is required, why do you think so?!?
>>
>> My build (LLVM 8) broke on an unknown builtin
>> (__builtin_preserve_access_index), which led me to this thread from
>> September with LLVM version information:
>>
>> https://lore.kernel.org/netdev/0a5bf608-bb15-c116-8e58-7224b6c3b62f(a)fb=
.com/
>>
>> I'll try skipping the problem builds like you mentioned on IRC.
>
> Running the attached script before 'make clean; make' in the eBPF self-
> tests, I'm able to do reproduce successful builds - not sure if it's
> luck or some stale 'good' status.
>
> It looks like that deteting files is 'the way' to disable ebpf tests :(
>

Thanks for the script! It didn't seem to produce a working build with =

Fedora 30 / llvm8, but Fedora 31 / llvm9 builds ok.

--
Mat Martineau
Intel
--===============4055352011486510818==--
