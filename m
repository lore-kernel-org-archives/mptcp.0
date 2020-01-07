Content-Type: multipart/mixed; boundary="===============7914117455557594571=="
MIME-Version: 1.0
From: Mat Martineau <mathew.j.martineau at linux.intel.com>
To: mptcp at lists.01.org
Subject: [MPTCP] Re: [PATCH v2] Squash-to: "sock: Make sk_protocol a 16-bit
 value"
Date: Tue, 07 Jan 2020 10:05:49 -0800
Message-ID: <alpine.OSX.2.21.2001071004480.15534@fepiepan-mobl.amr.corp.intel.com>
In-Reply-To: alpine.OSX.2.21.2001070958320.15534@fepiepan-mobl.amr.corp.intel.com
X-Status: 
X-Keywords:                  
X-UID: 3266

--===============7914117455557594571==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


On Tue, 7 Jan 2020, Mat Martineau wrote:

>
> On Tue, 7 Jan 2020, Paolo Abeni wrote:
>
>> We need to update the ebpf accessors for both sk_type and
>> sk_protocol. The code previously in place has some special
>> hack to take care such fields being part of a bitfield.
>> =

>> The fix actually clean-up a bit the existing code.
>> =

>> Note: I'm not 100% sure about dropping the '*target_size =3D '
>> instructions, my take is that the full ebpf register is loaded
>> with the (short) values. AFAICS other short field accesses
>> do not set 'targer_size', too.
>> =

>> to be appended to the orig commit message:
>> """
>> Take care of BPF field access for sk_type/sk_protocol.
>> Both of them are now outside the bitfield, so we can use
>> load instructions without further shifting/masking.
>> =

>> v5 -> v6:
>> - update eBPF accessors, too.
>> """
>> =

>> Additionally, Eric's Reviewed-by should be dropped.
>> =

>> v1 -> v2:
>> - replace BPF_H with BPF_FIELD_SIZEOF, plus indentation
>>   adjust (matttbe)
>
> Based on code review and applying/building the patch, I think it this is =
good =

> to merge/squash.
>
> I'm still working on getting the relevant ebpf selftest to run locally an=
d =

> would like to replicate Paolo's results before sending v6. If any fixes a=
re =

> required we can squash those too.
>

One more thing - should we cc the BPF maintainer(s) on this patch when =

submitting to netdev?

--
Mat Martineau
Intel
--===============7914117455557594571==--
