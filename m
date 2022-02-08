Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2662F27
	for <mptcp@lists.linux.dev>; Tue,  8 Feb 2022 19:40:16 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id st12so795696ejc.4
        for <mptcp@lists.linux.dev>; Tue, 08 Feb 2022 11:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to;
        bh=GDzGgbNh6sk7MqoI29MaRtzT2GU3IC81h3shMTZNSNY=;
        b=4d5taSVHpk1jylzDgIhICIaVu/PI9ea5MqXTLydNgdLuyaav8pkRA+Qkvsm4Y96SWM
         5vol1hNykbokWVO/MgECiqrB26r9OodXWTEPPi0NyvEPaSMmdTfdZOaacfSK4fOTQ2GP
         2ZzQwEYzR04qIp9MYIr87j5ugljSGdw69Covma3D5YAXot98rPADkYho5DJAg6ZQ4uEM
         RBnQbWDvJl/mmqa4qvVWtJdUdHFd0s0HpkGoS0RYbDZwHrRvUONMJ0LgcZ6aZATTtpQH
         DwZOmw04mbjH2252D/16pG4Wfebhf8PoidBc+K54gDcg4L8Hi53dfQSLCsfmkQ99ixKE
         QWEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to;
        bh=GDzGgbNh6sk7MqoI29MaRtzT2GU3IC81h3shMTZNSNY=;
        b=2S+3K3st8d7RP+hTJvgfrlTyjaWT+B+CNqlbLdK9M11aYvIY7zl0TXwG1YQeua0Ds2
         /BnlIbETyvcfMkJ4F5cmxy9+pfxBhOX1AxuOdyjoAwXr3Kq5JOb3nJsoK1iQaF/yCyeN
         XBy5i2FL9ewGNbb8fNQ4aGaxVJ4zTGq67LtuU0R6rwTFapgbO1HWyBWQyBYcbNxyZ53o
         ahQAXdUxFEtj2f5J/Aa0QBjaVGn0L40eQTi53/yWuKdHUW9O1PGaF4H0tCw7SHEo9h6b
         wy2AdIz07BqxCaqjTj1tMyGIfLaBwuXT3LrJdtUYiDGy3e3gYZbT+7DjKYiifsxWd7cv
         +Swg==
X-Gm-Message-State: AOAM531ozZGEA1zw8Q4w5zwcvRvQ6Vfmdu+y8Wb4zOdOc9BR2IHgtlte
	Hgl2WX4PursuItDx/bcrPj8iDbRtyG8EkZMqHX4=
X-Google-Smtp-Source: ABdhPJxQtgVra0tN/cMlkea/f1VzPT0ZqnCZEWXVJFfd33qCvgqBn2+TsY9EBT82Wuy24HTgzqYZhQ==
X-Received: by 2002:a17:907:3f29:: with SMTP id hq41mr1130533ejc.43.1644349214683;
        Tue, 08 Feb 2022 11:40:14 -0800 (PST)
Received: from ?IPV6:2a02:578:8593:1200:785b:5f52:bc3a:8a92? ([2a02:578:8593:1200:785b:5f52:bc3a:8a92])
        by smtp.gmail.com with ESMTPSA id zc8sm2437127ejb.150.2022.02.08.11.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Feb 2022 11:40:14 -0800 (PST)
Content-Type: multipart/mixed; boundary="------------ZDOT6qe9ZRxw1fixnv6TQqNt"
Message-ID: <924ab674-30b0-790e-32cc-fe33f0c8ca85@tessares.net>
Date: Tue, 8 Feb 2022 20:40:13 +0100
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
From: Matthieu Baerts <matthieu.baerts@tessares.net>
To: Geliang Tang <geliang.tang@suse.com>,
 Mat Martineau <mathew.j.martineau@linux.intel.com>
Cc: mptcp@lists.linux.dev
References: <cover.1643110285.git.geliang.tang@suse.com>
 <064cfe306debc535413c1d39fcf3b8d24a959eeb.1643110285.git.geliang.tang@suse.com>
 <b4708d63-29aa-da51-f536-3b5bf5399221@linux.intel.com>
 <a5500825-43a0-93c4-ba92-f3a24d4a202c@tessares.net>
 <CA+WQbwtY-qKu+_yNGcq3g5wDu7ZD0WwpSDbT7n1SLdw0ZtxwrA@mail.gmail.com>
 <eb33b5d3-a6e8-55d0-a149-c045ec2ecab5@tessares.net>
 <20220207140854.GA2916@localhost>
 <63c6dc9c-fa32-cf8b-2f5d-4fc5c51447b2@tessares.net>
 <20220208154110.GA28531@localhost>
 <20746295-b038-b485-ea6f-4f14dc7bf1cd@tessares.net>
In-Reply-To: <20746295-b038-b485-ea6f-4f14dc7bf1cd@tessares.net>

This is a multi-part message in MIME format.
--------------ZDOT6qe9ZRxw1fixnv6TQqNt
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Geliang,

On 08/02/2022 17:24, Matthieu Baerts wrote:
> Hi Geliang,
> 
> On 08/02/2022 16:41, Geliang Tang wrote:
>> Hi Matt, Mat,
>>
>> On Tue, Feb 08, 2022 at 01:26:10PM +0100, Matthieu Baerts wrote:
>>> Hi Geliang,
>>>
>>> On 07/02/2022 15:08, Geliang Tang wrote:
>>>> On Mon, Feb 07, 2022 at 11:32:05AM +0100, Matthieu Baerts wrote:
>>>>> Hi Geliang,
>>>>>
>>>>> On 07/02/2022 05:13, Geliang Tang wrote:
>>>>>> Hi Matt,
>>>>>>
>>>>>> Matthieu Baerts <matthieu.baerts@tessares.net> 于2022年1月29日周六 01:04写道：
>>>>>>>
>>>>>>> Hi Mat, Geliang,
>>>>>>>
>>>>>>> On 27/01/2022 01:07, Mat Martineau wrote:
>>>>>>>> On Tue, 25 Jan 2022, Geliang Tang wrote:
>>>>>>>>
>>>>>>>>> Added the test cases for MP_FAIL, use 'tc' commands to trigger the
>>>>>>>>> checksum failures.
>>>>>>>>>
>>>>>>>>
>>>>>>>> This patch is working well with the inverted byte detection, thanks!
>>>>>>>
>>>>>>> The public CI seems quite happy with the new version, good work :)
>>>>>>>
>>>>>>> Here is its report:
>>>>>>>
>>>>>>> ====== 8< ======
>>>>>>> Our CI did some validations and here is its report:
>>>>>>>
>>>>>>> - KVM Validation: normal:
>>>>>>>   - Unstable: 1 failed test(s): selftest_mptcp_join 🔴:
>>>>>>>   - Task: https://cirrus-ci.com/task/4993794666921984
>>>>>>>   - Summary:
>>>>>>> https://api.cirrus-ci.com/v1/artifact/task/4993794666921984/summary/summary.txt
>>>>>>>
>>>>>>> - KVM Validation: debug:
>>>>>>>   - Unstable: 2 failed test(s): selftest_diag selftest_mptcp_join 🔴:
>>>>>>>   - Task: https://cirrus-ci.com/task/4682233209421824
>>>>>>>   - Summary:
>>>>>>> https://api.cirrus-ci.com/v1/artifact/task/4682233209421824/summary/summary.txt
>>>>>>>
>>>>>>> Initiator: Patchew Applier
>>>>>>> Commits:
>>>>>>> https://github.com/multipath-tcp/mptcp_net-next/commits/c52e51136372
>>>>>>> ====== 8< ======
>>>>>>>
>>>>>>> But if you look at the logs [1], there are probably 3 last things to
>>>>>>> improve:
>>>>>>>
>>>>>>> [1] https://api.cirrus-ci.com/v1/task/4993794666921984/logs/test.log
>>>>>>>
>>>>>>> This line is repeated 90+ times:
>>>>>>>
>>>>>>>   tc action pedit offset 162 out of bounds
>>>>>>>
>>>>>>> (we talked about this one at the last meeting with ideas on how to
>>>>>>> reduce/get rid of them)
>>>>>>>
>>>>>>
>>>>>> Dose 'tc + iptables' work for our case?
>>>>>>
>>>>>> Use iptables to select the packets with enough data. Then use tc to
>>>>>> edit the selected packets only. (I don't know how to do it yet.)
>>>>>>
>>>>>> Here's a link about this:
>>>>>>
>>>>>> https://wiki.archlinux.org/title/advanced_traffic_control#Using_tc_+_iptables
>>>>>> .
>>>>>> '''
>>>>>> Using tc + iptables
>>>>>>
>>>>>> Iptables has a method called fwmark that can be used to mark packets
>>>>>> across interfaces.
>>>>>>
>>>>>> First, this makes packets marked with 6, to be processed by the 1:30 class
>>>>>>
>>>>>> # tc filter add dev eth0 protocol ip parent 1: prio 1 handle 6 fw flowid 1:30
>>>>>>
>>>>>> This sets that mark 6, using iptables
>>>>>>
>>>>>> # iptables -A PREROUTING -t mangle -i eth0 -j MARK --set-mark 6
>>>>>>
>>>>>> You can then use iptables normally to match packets and then mark them
>>>>>> with fwmark.
>>>>>> '''
>>>>>
>>>>> Good idea, probably simpler!
>>>>>
>>>>> I guess we can mark some packets in POSTROUTING and modify the egress TC
>>>>> rule.
>>>>>
>>>>> Do you need a hand for that?
>>>>>
>>>>
>>>> Thanks, Matt, I really need your help :)
>>>
>>> Sure.
>>> May you try the attached patch if you don't mind?
>>
>> Great! Thanks Matt. I just tested your patch, the single subflow test
>> ("002 1 MP_FAIL, single subflow") works well. And very stable. The two
>> issues that I mentioned in the cover letter of this series didn't happen
>> when running this new selftest. So the first two squash-to patches in
>> this series can be dropped.
> 
> That's nice! Thank you for having tested, I'm glad it helped!
> 
>> Mat, it looks like no need to analyse my attached pcaps any more. Thanks
>> for your help.
>>
>>>
>>> I now have this output:
>>>
>>> 001 0 MP_FAIL, multiple subflows         syn[ ok ] - synack[ ok ] - ack[
>>> ok ]
>>>                                          sum[ ok ] - csum  [ ok ]
>>>                                          ftx[ ok ] - frx   [ ok ]
>>>                                          itx[ ok ] - irx   [ ok ]
>>
>> But the multiple subflows test ("001 0 MP_FAIL, multiple subflows") doesn't
>> work. I'll try to fix it tomorrow. I think it's easy to fix.

Yes, we need to restrict the 'iptables' command to the same interface as
the one used with the TC command. Otherwise we will mark a flow for
another interface and TC will never see a marked packet for this interface.

> Yes, it looked strange to me. I guess the test should fail if 'nr_fail'
> is set to 0, no?
> Or probably we should no longer use 'get_nr_fail' as we expect to have
> only one MP_FAIL, no?
> 
> In the IPTables rule I added, I asked to mark the first packet that is
> over 150 bytes. We can change "--packet" if we want to mark the Xth one.
> And "--every" if we have more packets but worst case, that's not an
> issue to corrupt another one I think: on this path, either we have no
> more subflow (multiple subflows case) or no more MPTCP connection (1
> subflow case).
> 
>>
>> Thanks,
>> -Geliang
>>
>>> Created /tmp/tmp.SNhvH7ucj9 (size 512 KB) containing data sent by client
>>> Created /tmp/tmp.RFEqEXi0bl (size 512 KB) containing data sent by server
>>> file received by server has inverted byte at 69
>>> file received by server has inverted byte at 70
>>> file received by server has inverted byte at 71
>>> file received by server has inverted byte at 72
> 
> We can also modify the TC command to invert only a u8 instead of a u32
> to reduce the log entries here.

While at it, I also applied the suggestions I made here and above,
please see the attached patch. You can see a diff with the previous
version I sent here: https://paste.opendev.org/show/812608/

Cheers,
Matt
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------ZDOT6qe9ZRxw1fixnv6TQqNt
Content-Type: text/x-patch; charset=UTF-8; name="iptables-mark-v2.patch"
Content-Disposition: attachment; filename="iptables-mark-v2.patch"
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
Y3AvbXB0Y3Bfam9pbi5zaAppbmRleCBhNTFiMDkxNWI3YjEuLmFlNTBkNjQxODZjMiAxMDA3
NTUKLS0tIGEvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4u
c2gKKysrIGIvdG9vbHMvdGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2pvaW4u
c2gKQEAgLTE4LDcgKzE4LDYgQEAgY2hlY2tzdW09MAogaXBfbXB0Y3A9MAogY2hlY2tfaW52
ZXJ0PTAKIHZhbGlkYXRlX2NoZWNrc3VtPTAKLW5yX2ZhaWw9MAogZG9fYWxsX3Rlc3RzPTEK
IAogVEVTVF9DT1VOVD0wCkBAIC0xNzIsMjMgKzE3MSwyMCBAQCByZXNldF93aXRoX2FsbG93
X2pvaW5faWQwKCkKIAogIyBNb2RpZnkgVENQIHBheWxvYWQgd2l0aG91dCBjb3JydXB0aW5n
IHRoZSBUQ1AgcGFja2V0CiAjCi0jIFRoaXMgcnVsZSBpbnZlcnRzIGEgMzItYml0IHdvcmQg
YXQgYnl0ZSBvZmZzZXQgMTQ4IGZvciBhbGwgVENQIEFDSwotIyBwYWNrZXRzIGNhcnJ5aW5n
IGVub3VnaCBkYXRhLgotIyBPbmNlIGl0IGlzIGRvbmUsIHRoZSBUQ1AgQ2hlY2tzdW0gZmll
bGQgaXMgdXBkYXRlZCBzbyB0aGUgcGFja2V0Ci0jIGlzIHN0aWxsIGNvbnNpZGVyZWQgYXMg
dmFsaWQgYXQgdGhlIFRDUCBsZXZlbC4KLSMgQnV0IGJlY2F1c2UgdGhlIE1QVENQIGNoZWNr
c3VtLCBjb3ZlcmluZyB0aGUgVENQIG9wdGlvbnMgYW5kIGRhdGEsCi0jIGhhcyBub3QgYmVl
biB1cGRhdGVkLCB3ZSB3aWxsIGRldGVjdCB0aGUgbW9kaWZpY2F0aW9uIGFuZCBlbWl0IGFu
Ci0jIE1QX0ZBSUw6IHdoYXQgd2Ugd2FudCB0byB2YWxpZGF0ZSBoZXJlLgorIyBUaGlzIHJ1
bGUgaW52ZXJ0cyBhIDgtYml0IHdvcmQgYXQgYnl0ZSBvZmZzZXQgMTQ4IGZvciB0aGUgMm5k
IFRDUCBBQ0sgcGFja2V0cworIyBjYXJyeWluZyBlbm91Z2ggZGF0YS4KKyMgT25jZSBpdCBp
cyBkb25lLCB0aGUgVENQIENoZWNrc3VtIGZpZWxkIGlzIHVwZGF0ZWQgc28gdGhlIHBhY2tl
dCBpcyBzdGlsbAorIyBjb25zaWRlcmVkIGFzIHZhbGlkIGF0IHRoZSBUQ1AgbGV2ZWwuCisj
IEJlY2F1c2UgdGhlIE1QVENQIGNoZWNrc3VtLCBjb3ZlcmluZyB0aGUgVENQIG9wdGlvbnMg
YW5kIGRhdGEsIGhhcyBub3QgYmVlbgorIyB1cGRhdGVkLCB0aGUgbW9kaWZpY2F0aW9uIHdp
bGwgYmUgZGV0ZWN0ZWQgYW5kIGFuIE1QX0ZBSUwgd2lsbCBiZSBlbWl0dGVkOgorIyB3aGF0
IHdlIHdhbnQgdG8gdmFsaWRhdGUgaGVyZSB3aXRob3V0IGNvcnJ1cHRpbmcgInJhbmRvbSIg
TVBUQ1Agb3B0aW9ucy4KICMKLSMgUGxlYXNlIG5vdGUgdGhhdCB0aGlzIHJ1bGUgd2lsbCBw
cm9kdWNlIHRoaXMgcHJfaW5mbygpIG1lc3NhZ2UgZm9yCi0jIGVhY2ggVENQIEFDSyBwYWNr
ZXRzIG5vdCBjYXJyeWluZyBlbm91Z2ggZGF0YToKKyMgVG8gYXZvaWQgaGF2aW5nIHRjIHBy
b2R1Y2luZyB0aGlzIHByX2luZm8oKSBtZXNzYWdlIGZvciBlYWNoIFRDUCBBQ0sgcGFja2V0
cworIyBub3QgY2FycnlpbmcgZW5vdWdoIGRhdGE6CiAjCiAjICAgICB0YyBhY3Rpb24gcGVk
aXQgb2Zmc2V0IDE2MiBvdXQgb2YgYm91bmRzCiAjCi0jIEJ1dCB0aGlzIHNob3VsZCBiZSBs
aW1pdGVkIHRvIGEgdmVyeSBmZXcgbnVtYmVycyBvZiBwYWNrZXRzIGFzIHdlCi0jIHJlc3Ry
aWN0IHRoaXMgcnVsZSB0byBvdXRnb2luZyBUQ1AgdHJhZmZpYyB3aXRoIG9ubHkgdGhlIEFD
SyBmbGFnCi0jICsgZXhjZXB0IHRoZSAzcmQgQUNLLCBvbmx5IHBhY2tldHMgY2Fycnlpbmcg
ZGF0YSBzaG91bGQgYmUgc2VlbiBpbgotIyB0aGlzIGRpcmVjdGlvbi4KKyMgTmV0ZmlsdGVy
IGlzIHVzZWQgdG8gbWFyayBwYWNrZXRzIHdpdGggZW5vdWdoIGRhdGEuCiByZXNldF93aXRo
X2ZhaWwoKQogewogCXJlc2V0CkBAIC0xOTgsMTQgKzE5NCwyMiBAQCByZXNldF93aXRoX2Zh
aWwoKQogCiAJY2hlY2tfaW52ZXJ0PTEKIAl2YWxpZGF0ZV9jaGVja3N1bT0xCi0JbnJfZmFp
bD0wCi0JaT0iJDEiCisJbG9jYWwgaT0iJDEiCisKKwlpcCBuZXRucyBleGVjICRuczIgaXB0
YWJsZXMgXAorCQktdCBtYW5nbGUgXAorCQktQSBPVVRQVVQgXAorCQktbyBuczJldGgkaSBc
CisJCS1wIHRjcCBcCisJCS1tIGxlbmd0aCAtLWxlbmd0aCAxNTA6OTk5OSBcCisJCS1tIHN0
YXRpc3RpYyAtLW1vZGUgbnRoIC0tcGFja2V0IDEgLS1ldmVyeSA5OTk5OSBcCisJCS1qIE1B
UksgLS1zZXQtbWFyayA0MgogCiAJdGMgLW4gJG5zMiBxZGlzYyBhZGQgZGV2IG5zMmV0aCRp
IGNsc2FjdAogCXRjIC1uICRuczIgZmlsdGVyIGFkZCBkZXYgbnMyZXRoJGkgZWdyZXNzIFwK
IAkJcHJvdG9jb2wgaXAgcHJpbyAxMDAwIFwKLQkJZmxvd2VyIGlwX3Byb3RvIHRjcCB0Y3Bf
ZmxhZ3MgMHgxMC8weGZmIFwKLQkJYWN0aW9uIHBlZGl0IG11bmdlIG9mZnNldCAxNDggdTMy
IGludmVydCBcCisJCWhhbmRsZSA0MiBmdyBcCisJCWFjdGlvbiBwZWRpdCBtdW5nZSBvZmZz
ZXQgMTQ4IHU4IGludmVydCBcCiAJCXBpcGUgY3N1bSB0Y3AgXAogCQlpbmRleCAxMDAKIH0K
QEAgLTIyOCwxMiArMjMyLDYgQEAgaWYgWyAkPyAtbmUgMCBdO3RoZW4KIAlleGl0ICRrc2Z0
X3NraXAKIGZpCiAKLWpxIC1WID4gL2Rldi9udWxsIDI+JjEKLWlmIFsgJD8gLW5lIDAgXTt0
aGVuCi0JZWNobyAiU0tJUDogQ291bGQgbm90IHJ1biBhbGwgdGVzdHMgd2l0aG91dCBqcSB0
b29sIgotCWV4aXQgJGtzZnRfc2tpcAotZmkKLQogcHJpbnRfZmlsZV9lcnIoKQogewogCWxz
IC1sICIkMSIgMT4mMgpAQCAtMjk0LDIxICsyOTIsNiBAQCBsaW5rX2ZhaWx1cmUoKQogCWRv
bmUKIH0KIAotZ2V0X25yX2ZhaWwoKQotewotCWk9IiQxIgotCi0JbG9jYWwgYWN0aW9uPSQo
dGMgLW4gJG5zMiAtaiAtcyBhY3Rpb24gc2hvdyBhY3Rpb24gcGVkaXQgaW5kZXggMTAwKQot
CWxvY2FsIHBhY2tldHM9JChlY2hvICRhY3Rpb24gfCBqcSAnLlsxXS5hY3Rpb25zWzBdLnN0
YXRzLnBhY2tldHMnKQotCWxvY2FsIG92ZXJsaW1pdHM9JChlY2hvICRhY3Rpb24gfCBqcSAn
LlsxXS5hY3Rpb25zWzBdLnN0YXRzLm92ZXJsaW1pdHMnKQotCi0JbGV0IHBrdD0kcGFja2V0
cy0kb3ZlcmxpbWl0cwotCWlmIFsgJHBrdCAtZ3QgMCBdOyB0aGVuCi0JCW5yX2ZhaWw9MQot
CWZpCi0JdGMgLW4gJG5zMiBxZGlzYyBkZWwgZGV2IG5zMmV0aCRpIGNsc2FjdAotfQotCiAj
ICQxOiBJUCBhZGRyZXNzCiBpc192NigpCiB7CkBAIC0yMjU5LDE2ICsyMjQyLDE0IEBAIGZh
aWxfdGVzdHMoKQogCXBtX25sX2FkZF9lbmRwb2ludCAkbnMyIDEwLjAuMi4yIGRldiBuczJl
dGgyIGZsYWdzIHN1YmZsb3cKIAlwbV9ubF9hZGRfZW5kcG9pbnQgJG5zMiAxMC4wLjMuMiBk
ZXYgbnMyZXRoMyBmbGFncyBzdWJmbG93CiAJcnVuX3Rlc3RzICRuczEgJG5zMiAxMC4wLjEu
MSAzCi0JZ2V0X25yX2ZhaWwgMgotCWNoa19qb2luX25yICIkbnJfZmFpbCBNUF9GQUlMLCBt
dWx0aXBsZSBzdWJmbG93cyIgMiAyIDIgJG5yX2ZhaWwKKwljaGtfam9pbl9uciAiTVBfRkFJ
TCwgbXVsdGlwbGUgc3ViZmxvd3MiIDIgMiAyIDEKIAogCSMgc2luZ2xlIHN1YmZsb3cKIAly
ZXNldF93aXRoX2ZhaWwgMQogCXBtX25sX3NldF9saW1pdHMgJG5zMSAwIDIKIAlwbV9ubF9z
ZXRfbGltaXRzICRuczIgMCAyCiAJcnVuX3Rlc3RzICRuczEgJG5zMiAxMC4wLjEuMSA0Ci0J
Z2V0X25yX2ZhaWwgMQotCWNoa19qb2luX25yICIkbnJfZmFpbCBNUF9GQUlMLCBzaW5nbGUg
c3ViZmxvdyIgMCAwIDAgJG5yX2ZhaWwgMAorCWNoa19qb2luX25yICJNUF9GQUlMLCBzaW5n
bGUgc3ViZmxvdyIgMCAwIDAgMSAwCiB9CiAKIGFsbF90ZXN0cygp

--------------ZDOT6qe9ZRxw1fixnv6TQqNt--
