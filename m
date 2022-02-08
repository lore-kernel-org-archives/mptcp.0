Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953D2C9C
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 12:26:13 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id eg42so21320675edb.7
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 04:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=jlKuzRLX+MDL0URDp9OziAIBp5dNkYOYuCA+46bPE+k=;
        b=d/KMD7QAbCEc9Ij1ap+oIuLPX8x9dE7KFkdrtr+6a0HvGGHaiZtpAzVXX88syFWC8w
         UILGclaBdgSk4Et7YZ6zM1q9IEQy978ohXEs9kNiIksPaipK4G7DVpNHmWFaL6WFO3Gq
         uXoCbqn8eAiujLakxeuJDX8M/w6LUOMTOAXQ9Y6oxmSQ9wwt9+OYeJ0rlctKTldfLQYC
         Bp8tqdoJAQynFcCjs6vR7WLe3v8itYUObUeOUiPn8STKibhd5yGLtK9L5aa1rcMsYm58
         9DJMDNwAPjpHPCsA5rWbOMMg9q0wRa1KUdyR/RIX91l+TmY7XVbvPhm/wZRUuzqZK4EX
         h8mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=jlKuzRLX+MDL0URDp9OziAIBp5dNkYOYuCA+46bPE+k=;
        b=FJM1psa8jq0V0jdQGS32uLAWIs0+nGOR0YIUhaIWL/R0XU/jMEUqho/MQOfxf54fww
         CCKfTp6vKPMxJztDDX3W55CrOTzAIIUHx6Zknpl3yLnqHYDQM9kF6mdgSo/qNv3bB6Q8
         xyjBegvVy4WVt5taUpqcFkM5l2Jn9ycLitIeVmgTEpdJGFX3ubQSc6mrxvfE2YBZa4Kw
         ITh+a7fTy/Y1opNWMCq4+uZcgutgwsk3GaeolyXysf5XHtw0eUURYOlW+21nMFkMrIbX
         D80tUGbeRS0Fnuty01bIzhfyGCsqJGFIrHuJjrgr5uptjU+G+BkrHpvz7aEzoWg8ciWh
         rAww==
X-Gm-Message-State: AOAM531L/B/smRdTrtyiNblAxnFnhJfXeIpztN59YUT26Cl6ClXIjAXA
	Bb5iNmoFMEOFWxmVmhg2dW0/BlpP6YEgnxdNiQ4=
X-Google-Smtp-Source: ABdhPJyLb1yw6S0uIDoctEJOFDHILLt8Wpfg4rrRORp3iD9kAML8vIQ/bCoSygIAFqX8vl6cxRsXuQ==
X-Received: by 2002:a05:6402:d0d:: with SMTP id eb13mr4308595edb.92.1644323171491;
        Tue, 08 Feb 2022 04:26:11 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:e2d4:3fdf:b2fc:a61e? ([2a02:578:8593:1200:e2d4:3fdf:b2fc:a61e])
        by smtp.gmail.com with ESMTPSA id g8sm4734271ejt.26.2022.02.08.04.26.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 04:26:11 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------jJrVB0cdztPCXBEzHm4wStRa"
Message-ID: <63c6dc9c-fa32-cf8b-2f5d-4fc5c51447b2@tessares.net>
Date: Tue, 8 Feb 2022 13:26:10 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH mptcp-next 3/3] selftests: mptcp: add mp_fail testcases
Content-Language: en-GB
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
 <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
 <20220207140854.GA2916@localhost>
From: Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20220207140854.GA2916@localhost>

This is a multi-part message in MIME format.
--------------jJrVB0cdztPCXBEzHm4wStRa
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 07/02/2022 15:08, Geliang Tang wrote:
> On Mon, Feb 07, 2022 at 11:32:05AM +0100, Matthieu Baerts wrote:
>> Hi Geliang,
>>
>> On 07/02/2022 05:13, Geliang Tang wrote:
>>> Hi Matt,
>>>
>>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月29日周六 01:04写道：
>>>>
>>>> Hi Mat, Geliang,
>>>>
>>>> On 27/01/2022 01:07, Mat Martineau wrote:
>>>>> On Tue, 25 Jan 2022, Geliang Tang wrote:
>>>>>
>>>>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
>>>>>> checksum failures.
>>>>>>
>>>>>
>>>>> This patch is working well with the inverted byte detection, thanks!
>>>>
>>>> The public CI seems quite happy with the new version, good work :)
>>>>
>>>> Here is its report:
>>>>
>>>> ====== 8< ======
>>>> Our CI did some validations and here is its report:
>>>>
>>>> - KVM Validation: normal:
>>>>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>>>>   - Task: https://cirrus-ci.com/task/4993794666921984
>>>>   - Summary:
>>>> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/summary.txt
>>>>
>>>> - KVM Validation: debug:
>>>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>>>>   - Task: https://cirrus-ci.com/task/4682233209421824
>>>>   - Summary:
>>>> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/summary.txt
>>>>
>>>> Initiator: Patchew Applier
>>>> Commits:
>>>> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
>>>> ====== 8< ======
>>>>
>>>> But if you look at the logs [1], there are probably 3 last things to
>>>> improve:
>>>>
>>>> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
>>>>
>>>> This line is repeated 90+ times:
>>>>
>>>>   tc action pedit offset 162 out of bounds
>>>>
>>>> (we talked about this one at the last meeting with ideas on how to
>>>> reduce/get rid of them)
>>>>
>>>
>>> Dose 'tc + iptables' work for our case?
>>>
>>> Use iptables to select the packets with enough data. Then use tc to
>>> edit the selected packets only. (I don't know how to do it yet.)
>>>
>>> Here's a link about this:
>>>
>>> https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_iptables
>>> .
>>> '''
>>> Using tc + iptables
>>>
>>> Iptables has a method called fwmark that can be used to mark packets
>>> across interfaces.
>>>
>>> First, this makes packets marked with 6, to be processed by the 1:30 class
>>>
>>> # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flowid 1:30
>>>
>>> This sets that mark 6, using iptables
>>>
>>> # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
>>>
>>> You can then use iptables normally to match packets and then mark them
>>> with fwmark.
>>> '''
>>
>> Good idea, probably simpler!
>>
>> I guess we can mark some packets in POSTROUTING and modify the egress TC
>> rule.
>>
>> Do you need a hand for that?
>>
> 
> Thanks, Matt, I really need your help :)

Sure.
May you try the attached patch if you don't mind?

I now have this output:

001 0 MP_FAIL, multiple subflows         syn[ ok ] - synack[ ok ] - ack[
ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - frx   [ ok ]
                                         itx[ ok ] - irx   [ ok ]
Created /tmp/tmp.SNhvH7ucj9 (size 512 KB) containing data sent by client
Created /tmp/tmp.RFEqEXi0bl (size 512 KB) containing data sent by server
file received by server has inverted byte at 69
file received by server has inverted byte at 70
file received by server has inverted byte at 71
file received by server has inverted byte at 72
002 1 MP_FAIL, single subflow            syn[ ok ] - synack[ ok ] - ack[
ok ]
                                         sum[ ok ] - csum  [ ok ]
                                         ftx[ ok ] - frx   [ ok ]
                                         itx[ ok ] - irx   [ ok ]

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------jJrVB0cdztPCXBEzHm4wStRa
Content-Type: text/x-patch; charset=UTF-8; name="iptables-mark.patch"
Content-Disposition: attachment; filename="iptables-mark.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9jb25maWcg
Yi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0Y3AvY29uZmlnCmluZGV4IDI2OTU1
YWJlNDlmMC4uMzgwMjFhMGRkNTI3IDEwMDY0NAotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQvbXB0Y3AvY29uZmlnCisrKyBiL3Rvb2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25l
dC9tcHRjcC9jb25maWcKQEAgLTEyLDYgKzEyLDkgQEAgQ09ORklHX05GX1RBQkxFUz1tCiBD
T05GSUdfTkZUX0NPTVBBVD1tCiBDT05GSUdfTkVURklMVEVSX1hUQUJMRVM9bQogQ09ORklH
X05FVEZJTFRFUl9YVF9NQVRDSF9CUEY9bQorQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9M
RU5HVEg9bQorQ09ORklHX05FVEZJTFRFUl9YVF9NQVRDSF9TVEFUSVNUSUM9bQorQ09ORklH
X05FVEZJTFRFUl9YVF9UQVJHRVRfTUFSSz1tCiBDT05GSUdfTkZfVEFCTEVTX0lORVQ9eQog
Q09ORklHX05GVF9UUFJPWFk9bQogQ09ORklHX05GVF9TT0NLRVQ9bQpAQCAtMjIsNSArMjUs
NSBAQCBDT05GSUdfSVBWNl9NVUxUSVBMRV9UQUJMRVM9eQogQ09ORklHX05FVF9BQ1RfQ1NV
TT1tCiBDT05GSUdfTkVUX0FDVF9QRURJVD1tCiBDT05GSUdfTkVUX0NMU19BQ1Q9eQotQ09O
RklHX05FVF9DTFNfRkxPV0VSPW0KK0NPTkZJR19ORVRfQ0xTX0ZXPW0KIENPTkZJR19ORVRf
U0NIX0lOR1JFU1M9bQpkaWZmIC0tZ2l0IGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0
L21wdGNwL21wdGNwX2pvaW4uc2ggYi90b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy9uZXQvbXB0
Y3AvbXB0Y3Bfam9pbi5zaAppbmRleCBhNTFiMDkxNWI3YjEuLjUyYTBmM2RmM2IyZSAxMDA3
NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4u
c2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4u
c2gKQEAgLTE4MCwxNSArMTgwLDEyIEBAIHJlc2V0X3dpdGhfYWxsb3dfam9pbl9pZDAoKQog
IyBoYXMgbm90IGJlZW4gdXBkYXRlZCwgd2Ugd2lsbCBkZXRlY3QgdGhlIG1vZGlmaWNhdGlv
biBhbmQgZW1pdCBhbgogIyBNUF9GQUlMOiB3aGF0IHdlIHdhbnQgdG8gdmFsaWRhdGUgaGVy
ZS4KICMKLSMgUGxlYXNlIG5vdGUgdGhhdCB0aGlzIHJ1bGUgd2lsbCBwcm9kdWNlIHRoaXMg
cHJfaW5mbygpIG1lc3NhZ2UgZm9yCi0jIGVhY2ggVENQIEFDSyBwYWNrZXRzIG5vdCBjYXJy
eWluZyBlbm91Z2ggZGF0YToKKyMgVG8gYXZvaWQgaGF2aW5nIHRjIHByb2R1Y2luZyB0aGlz
IHByX2luZm8oKSBtZXNzYWdlIGZvciBlYWNoIFRDUCBBQ0sgcGFja2V0cworIyBub3QgY2Fy
cnlpbmcgZW5vdWdoIGRhdGE6CiAjCiAjICAgICB0YyBhY3Rpb24gcGVkaXQgb2Zmc2V0IDE2
MiBvdXQgb2YgYm91bmRzCiAjCi0jIEJ1dCB0aGlzIHNob3VsZCBiZSBsaW1pdGVkIHRvIGEg
dmVyeSBmZXcgbnVtYmVycyBvZiBwYWNrZXRzIGFzIHdlCi0jIHJlc3RyaWN0IHRoaXMgcnVs
ZSB0byBvdXRnb2luZyBUQ1AgdHJhZmZpYyB3aXRoIG9ubHkgdGhlIEFDSyBmbGFnCi0jICsg
ZXhjZXB0IHRoZSAzcmQgQUNLLCBvbmx5IHBhY2tldHMgY2FycnlpbmcgZGF0YSBzaG91bGQg
YmUgc2VlbiBpbgotIyB0aGlzIGRpcmVjdGlvbi4KKyMgTmV0ZmlsdGVyIGlzIHVzZWQgdG8g
bWFyayBwYWNrZXRzIHdpdGggZW5vdWdoIGRhdGEuCiByZXNldF93aXRoX2ZhaWwoKQogewog
CXJlc2V0CkBAIC0xOTksMTIgKzE5NiwyMCBAQCByZXNldF93aXRoX2ZhaWwoKQogCWNoZWNr
X2ludmVydD0xCiAJdmFsaWRhdGVfY2hlY2tzdW09MQogCW5yX2ZhaWw9MAotCWk9IiQxIgor
CWxvY2FsIGk9IiQxIgorCisJaXAgbmV0bnMgZXhlYyAkbnMyIGlwdGFibGVzIFwKKwkJLXQg
bWFuZ2xlIFwKKwkJLUEgT1VUUFVUIFwKKwkJLXAgdGNwIFwKKwkJLW0gbGVuZ3RoIC0tbGVu
Z3RoIDE1MDo5OTk5IFwKKwkJLW0gc3RhdGlzdGljIC0tbW9kZSBudGggLS1wYWNrZXQgMCAt
LWV2ZXJ5IDk5OTkgXAorCQktaiBNQVJLIC0tc2V0LW1hcmsgNDIKIAogCXRjIC1uICRuczIg
cWRpc2MgYWRkIGRldiBuczJldGgkaSBjbHNhY3QKIAl0YyAtbiAkbnMyIGZpbHRlciBhZGQg
ZGV2IG5zMmV0aCRpIGVncmVzcyBcCiAJCXByb3RvY29sIGlwIHByaW8gMTAwMCBcCi0JCWZs
b3dlciBpcF9wcm90byB0Y3AgdGNwX2ZsYWdzIDB4MTAvMHhmZiBcCisJCWhhbmRsZSA0MiBm
dyBcCiAJCWFjdGlvbiBwZWRpdCBtdW5nZSBvZmZzZXQgMTQ4IHUzMiBpbnZlcnQgXAogCQlw
aXBlIGNzdW0gdGNwIFwKIAkJaW5kZXggMTAwCkBAIC0yOTYsMTQgKzMwMSwxMiBAQCBsaW5r
X2ZhaWx1cmUoKQogCiBnZXRfbnJfZmFpbCgpCiB7Ci0JaT0iJDEiCisJbG9jYWwgaT0iJDEi
CiAKIAlsb2NhbCBhY3Rpb249JCh0YyAtbiAkbnMyIC1qIC1zIGFjdGlvbiBzaG93IGFjdGlv
biBwZWRpdCBpbmRleCAxMDApCiAJbG9jYWwgcGFja2V0cz0kKGVjaG8gJGFjdGlvbiB8IGpx
ICcuWzFdLmFjdGlvbnNbMF0uc3RhdHMucGFja2V0cycpCi0JbG9jYWwgb3ZlcmxpbWl0cz0k
KGVjaG8gJGFjdGlvbiB8IGpxICcuWzFdLmFjdGlvbnNbMF0uc3RhdHMub3ZlcmxpbWl0cycp
CiAKLQlsZXQgcGt0PSRwYWNrZXRzLSRvdmVybGltaXRzCi0JaWYgWyAkcGt0IC1ndCAwIF07
IHRoZW4KKwlpZiBbICRwYWNrZXRzIC1ndCAwIF07IHRoZW4KIAkJbnJfZmFpbD0xCiAJZmkK
IAl0YyAtbiAkbnMyIHFkaXNjIGRlbCBkZXYgbnMyZXRoJGkgY2xzYWN0

--------------jJrVB0cdztPCXBEzHm4wStRa--
