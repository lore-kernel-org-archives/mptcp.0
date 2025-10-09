Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D032DF68
	for <mptcp@lists.linux.dev>; Thu,  9 Oct 2025 07:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759996347; cv=none; b=sKS7xnW37aKwu+7aW8QhW7S1yc5+Pe8NFdZDyjG1eY8EKHYw0U7esTzTkBfriE5SJw92QM4+JRqBeQ9Gk0UeHNZgR4rWp/M3Pav1V3rmaEmphLDZ6STIqmVMvzRG2Z/FefvBfCdxduWKNCkabGGYKopcbuB96l/HieggVY36P5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759996347; c=relaxed/simple;
	bh=pLUm0UGiHcokPnhL9QO3zRn6UzqW79d2HEyBf/TkFZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UTYSq2WAj1FO2pEZqogBJk0YRsNwYaHHLe7cvHpqUyTLjzVD2Y6uEZvCHGw917ZiXMe76omxuzXpippNAoG2UXfbdFuIjzEZgNIZ3mPCdjaeb4AU8x5uRvcjfRuTTaNSaygRQ5WZh5IgC2bk7ndlRuVrNOi5oyg3DP0lgaisNQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dT6Vv+T2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dT6Vv+T2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759996344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=svDCXBNCAxq2Jg3TNoNrz+gK4P7FKqmYOLODsx9tiXE=;
	b=dT6Vv+T2tytjQ5vsqQmdvU/ML7+QW+qYf9PKgfcN0+kfGW43YQb3cZu04I6zNFdjrwLOF5
	6yHIBNZAHomxxWFPBmIrd4b8Vf/Hg7VPBMRJwGCwM1GTkYkSlWXh452awOfbYKAhKb48hd
	qYtF6+Y7TzdarPVk2W5kkZcY9slnBTU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-HfzvCnEkOAaDunYLJ3m0gw-1; Thu, 09 Oct 2025 03:52:22 -0400
X-MC-Unique: HfzvCnEkOAaDunYLJ3m0gw-1
X-Mimecast-MFC-AGG-ID: HfzvCnEkOAaDunYLJ3m0gw_1759996342
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3ee130237e1so352857f8f.0
        for <mptcp@lists.linux.dev>; Thu, 09 Oct 2025 00:52:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759996341; x=1760601141;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MTwW38s1i2XaaTwD7jEvt27YGwtDNXPsQk3Ci444Jgk=;
        b=kRAN3R3aINr+gbc/9IPQgJQVx/GLeQrCDrtoyUkgx/b93t8SCTs9sldhSuS2+NPF+n
         C6+s1nsQMLkG8cdkSRES3FLMu6bnlqExYb5IOZp2eocMGkLGK+1mp25FJtplekCmXH+u
         js25Xyzb9EIpyL8kscmY4NJMUA/duSMR3xriSxYZuqZ5I/r2kOB520TgtQd1Mg+ZR93o
         pefoDwRIkSk6JoGhg08IVQkzVH13MeGjZ4ZeZ3N8ZJRO10NpYUff1I9uzvYPsV6uTghd
         lGT0y69OwWn1c8HG4KBRmEkxZ40rMRLYA0W5Q8GY+6D/vcZ6XdCkMFANi0DZSKzpoCeC
         BzGg==
X-Forwarded-Encrypted: i=1; AJvYcCXeQwpppChxBFqfW0/FDCMCopb2XiqHw6X6i2IJMx8sWNSpipqjbkAE4gYndsgeF5TE+JM8jQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxoAa4vTdCobObT2MDq2hOkTTtk5wHYkQkzfXSnfNzGZWis51AD
	GymKz0cdF+DrGO7aewtp+9uQe3FPtuYl0cA7M2wEWX4IjWcXWVA0ZrRrvLDK/4woA7ihAnWV3I1
	bhQKeo1h1F+j60fVDjDDFBhtRV7K67Nkq3FI7FU8WOprevEvnucqQBFjv
X-Gm-Gg: ASbGncsf7EeKvW1bpAX+4s7vxoDDeN13baC3wZpKlIfKgy6RtWMEEBStn2ThBXl6EyS
	IT0xKtyLnzYE4pK9X0OR4wZLK0Vn67awD4P2Ch5KtKdjzJ7MN5FZQEkfyTArht7at5PRc8xoes1
	KofdGCT9z2fW+Ftm5nGVLS8d1b0Zq1lHNNi7OtAtRz/DArNKAaCu+HUJlNfqn3+PiEvTfrCFTxq
	Oju2j0+5DCqKpSmtA/HgyuLZSBV9oFtZ/IvdSri43LJdMkJsoWr+79blaao+oBoLtfDPqLxW802
	wI2h45FM84cDxGiPFhPlbo5/Bx6HbH7ncFBgDTCNR/l8zHCFnAMYeb8HSDOZGylU6J3wBbbx8+0
	LonrZtoF40R00b6u+bQ==
X-Received: by 2002:a05:6000:2410:b0:3ec:a019:3944 with SMTP id ffacd0b85a97d-4266e8db288mr3619493f8f.43.1759996341520;
        Thu, 09 Oct 2025 00:52:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEyVSJ93oK1vak22nBAA2PHnTbJHsF5zuOHK6Bi19uCu8RiKteSlh2aVjzl/7jMNsezKfqZTg==
X-Received: by 2002:a05:6000:2410:b0:3ec:a019:3944 with SMTP id ffacd0b85a97d-4266e8db288mr3619467f8f.43.1759996341014;
        Thu, 09 Oct 2025 00:52:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4255d8e9703sm33778208f8f.30.2025.10.09.00.52.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Oct 2025 00:52:20 -0700 (PDT)
Message-ID: <8a8feb1d-ad10-4ba4-a448-db8a0e45c7c3@redhat.com>
Date: Thu, 9 Oct 2025 09:52:19 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 mptcp-next 00/10] mptcp: introduce backlog processing
To: Geliang Tang <geliang@kernel.org>, Matthieu Baerts <matttbe@kernel.org>,
 mptcp@lists.linux.dev
References: <cover.1759737859.git.pabeni@redhat.com>
 <2c9f131e-ef34-4916-8aab-e1420e1ae90b@kernel.org>
 <d0a814c364e744ca6b836ccd5b6e9146882e8d42.camel@kernel.org>
 <b90e5899-6473-4b3b-a239-9202c2e2cb03@redhat.com>
 <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2389029f56a9fa496b59be7655987e6d9c6362f2.camel@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rsPWK4FiMqQa9ScVqtjvZSi5VGlFEqIhkXCs6bweGbw_1759996342
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------zsyLijCwJt75mnZDJr3wXu21"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------zsyLijCwJt75mnZDJr3wXu21
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/25 8:54 AM, Geliang Tang wrote:
> On Wed, 2025-10-08 at 09:30 +0200, Paolo Abeni wrote:
>> On 10/8/25 5:07 AM, Geliang Tang wrote:
>>> On Mon, 2025-10-06 at 19:07 +0200, Matthieu Baerts wrote:
>>>> Hi Paolo,
>>>>
>>>> On 06/10/2025 10:11, Paolo Abeni wrote:
>>>>> This series includes RX path improvement built around backlog
>>>>> processing
>>>> Thank you for the new version! This is not a review, but just a
>>>> note
>>>> to
>>>> tell you patchew didn't manage to apply the patches due to the
>>>> same
>>>> conflict that was already there with the v4 (mptcp_init_skb()
>>>> parameters
>>>> have been moved to the previous line). I just applied the patches
>>>> manually. While at it, I also used this test branch for syzkaller
>>>> to
>>>> validate them.
>>>>
>>>> (Also, on patch "mptcp: drop the __mptcp_data_ready() helper",
>>>> git
>>>> complained that there is a trailing whitespace.)
>>>
>>> Sorry, patches 9-10 break my "implement mptcp read_sock" v12
>>> series. I
>>> rebased this series on patches 1-8, it works well. But after
>>> applying
>>> patches 9-10, I changed mptcp_recv_skb() in [1] from
>>
>> Thanks for the feedback, the applied delta looks good to me.
>>
>>> # INFO: with MPTFO start
>>> # 57 ns2 MPTCP -> ns1 (10.0.1.1:10054      ) MPTCP     (duration
>>> 60989ms) [FAIL] client exit code 0, server 124
>>> # 
>>> # netns ns1-RqXF2p (listener) socket stat for 10054:
>>> # Failed to find cgroup2 mount
>>> # Failed to find cgroup2 mount
>>> # Failed to find cgroup2 mount
>>> # Netid State    Recv-Q Send-Q Local Address:Port  Peer
>>> Address:Port  
>>> # tcp   ESTAB    0      0           10.0.1.1:10054    
>>> 10.0.1.2:55516
>>> ino:2064372 sk:1 cgroup:unreachable:1 <->
>>> # 	 skmem:(r0,rb131072,t0,tb340992,f0,w0,o0,bl0,d0) sack
>>> cubic
>>> wscale:8,8 rto:206 rtt:5.026/10.034 ato:40 mss:1460 pmtu:1500
>>> rcvmss:1436 advmss:1460 cwnd:10 bytes_sent:115312
>>> bytes_retrans:1560
>>> bytes_acked:113752 bytes_received:5136 segs_out:85 segs_in:16
>>> data_segs_out:83 data_segs_in:4 send 23239156bps lastsnd:60939
>>> lastrcv:61035 lastack:60912 pacing_rate 343879640bps delivery_rate
>>> 1994680bps delivered:84 busy:123ms sndbuf_limited:41ms(33.3%)
>>> retrans:0/2 dsack_dups:2 rcv_space:14600 rcv_ssthresh:75432
>>> minrtt:0.003 rcv_wnd:75520 tcp-ulp-mptcp flags:Mec
>>> token:0000(id:0)/32ed0950(id:0) seq:2946228641406205031 sfseq:1
>>> ssnoff:1349223625 maplen:5136
>>> # mptcp LAST-ACK 0      0           10.0.1.1:10054    
>>> 10.0.1.2:55516
>>> timer:(keepalive,59sec,0) ino:0 sk:2 cgroup:unreachable:1 ---
>>> # 	 skmem:(r0,rb131072,t0,tb345088,f4088,w352264,o0,bl0,d0)
>>> subflows_max:2 remote_key token:32ed0950
>>> write_seq:6317574787800720824
>>> snd_una:6317574787800376423 rcv_nxt:2946228641406210168
>>> bytes_sent:113752 bytes_received:5136 bytes_acked:113752
>>> subflows_total:1 last_data_sent:60954 last_data_recv:61036
>>> last_ack_recv:60913                                       
>>
>> bytes_sent == bytes_sent, possibly we are missing a window-open
>> event,
>> which in turn should be triggered by a mptcp_cleanp_rbuf(), which
>> AFAICS
>> are correctly invoked in the splice code. TL;DR: I can't find
>> anything
>> obviously wrong :-P
>>
>> Also the default rx buf size is suspect.
>>
>> Can you reproduce the issue while capturing the traffic with tcpdump?
>> if
>> so, could you please share the capture?
> 
> Thank you for your suggestion. I've attached several tcpdump logs from
> when the tests failed.

Oh wow! the receiver actually sends the window open notification
(packets 527 and 528 in the trace), but the sender does not react at all.

I have no idea/I haven't digged yet why the sender did not try a zero
window probe (it should!), but it looks like we have some old bug in
sender wakeup since MPTCP_DEQUEUE introduction (which is very
surprising, why we did not catch/observe this earlier ?!?). That could
explain also sporadic mptcp_join failures.

Could you please try the attached patch?

/P

p.s. AFAICS the backlog introduction should just increase the frequency
of an already possible event...
--------------zsyLijCwJt75mnZDJr3wXu21
Content-Type: text/x-patch; charset=UTF-8;
 name="always_wakeup_snd_nxt_increase.patch"
Content-Disposition: attachment;
 filename="always_wakeup_snd_nxt_increase.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0L21wdGNwL3Byb3RvY29sLmMK
aW5kZXggYTkyZWNlYzFiZWIzYjMuLjI2OGVjNzUyZmZjMDFiIDEwMDY0NAotLS0gYS9uZXQvbXB0
Y3AvcHJvdG9jb2wuYworKysgYi9uZXQvbXB0Y3AvcHJvdG9jb2wuYwpAQCAtMTAzOCwxMiArMTAz
OCwxNCBAQCBzdGF0aWMgdm9pZCBkZnJhZ19jbGVhcihzdHJ1Y3Qgc29jayAqc2ssIHN0cnVjdCBt
cHRjcF9kYXRhX2ZyYWcgKmRmcmFnKQogfQogCiAvKiBjYWxsZWQgdW5kZXIgYm90aCB0aGUgbXNr
IHNvY2tldCBsb2NrIGFuZCB0aGUgZGF0YSBsb2NrICovCi1zdGF0aWMgdm9pZCBfX21wdGNwX2Ns
ZWFuX3VuYShzdHJ1Y3Qgc29jayAqc2spCitzdGF0aWMgdm9pZCBfX21wdGNwX2NsZWFuX3VuYV93
YWtldXAoc3RydWN0IHNvY2sgKnNrKQogewogCXN0cnVjdCBtcHRjcF9zb2NrICptc2sgPSBtcHRj
cF9zayhzayk7CiAJc3RydWN0IG1wdGNwX2RhdGFfZnJhZyAqZHRtcCwgKmRmcmFnOwogCXU2NCBz
bmRfdW5hOwogCisJbG9ja2RlcF9hc3NlcnRfaGVsZF9vbmNlKCZzay0+c2tfbG9jay5zbG9jayk7
CisKIAlzbmRfdW5hID0gbXNrLT5zbmRfdW5hOwogCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShk
ZnJhZywgZHRtcCwgJm1zay0+cnR4X3F1ZXVlLCBsaXN0KSB7CiAJCWlmIChhZnRlcjY0KGRmcmFn
LT5kYXRhX3NlcSArIGRmcmFnLT5kYXRhX2xlbiwgc25kX3VuYSkpCkBAIC0xMDk1LDEzICsxMDk3
LDYgQEAgc3RhdGljIHZvaWQgX19tcHRjcF9jbGVhbl91bmEoc3RydWN0IHNvY2sgKnNrKQogCiAJ
aWYgKG1wdGNwX3BlbmRpbmdfZGF0YV9maW5fYWNrKHNrKSkKIAkJbXB0Y3Bfc2NoZWR1bGVfd29y
ayhzayk7Ci19Ci0KLXN0YXRpYyB2b2lkIF9fbXB0Y3BfY2xlYW5fdW5hX3dha2V1cChzdHJ1Y3Qg
c29jayAqc2spCi17Ci0JbG9ja2RlcF9hc3NlcnRfaGVsZF9vbmNlKCZzay0+c2tfbG9jay5zbG9j
ayk7Ci0KLQlfX21wdGNwX2NsZWFuX3VuYShzayk7CiAJbXB0Y3Bfd3JpdGVfc3BhY2Uoc2spOwog
fQogCkBAIC0zNTEyLDcgKzM1MDcsNyBAQCBzdGF0aWMgdm9pZCBtcHRjcF9kZXN0cm95KHN0cnVj
dCBzb2NrICpzaykKIHZvaWQgX19tcHRjcF9kYXRhX2Fja2VkKHN0cnVjdCBzb2NrICpzaykKIHsK
IAlpZiAoIXNvY2tfb3duZWRfYnlfdXNlcihzaykpCi0JCV9fbXB0Y3BfY2xlYW5fdW5hKHNrKTsK
KwkJX19tcHRjcF9jbGVhbl91bmFfd2FrZXVwKHNrKTsKIAllbHNlCiAJCV9fc2V0X2JpdChNUFRD
UF9DTEVBTl9VTkEsICZtcHRjcF9zayhzayktPmNiX2ZsYWdzKTsKIH0KZGlmZiAtLWdpdCBhL3Rv
b2xzL3Rlc3Rpbmcvc2VsZnRlc3RzL25ldC9tcHRjcC9tcHRjcF9jb25uZWN0LnNoIGIvdG9vbHMv
dGVzdGluZy9zZWxmdGVzdHMvbmV0L21wdGNwL21wdGNwX2Nvbm5lY3Quc2gKaW5kZXggNjFhZTY3
NjJmNWI2MDEuLmExODVhYmUxM2I5NWM0IDEwMDc1NQotLS0gYS90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5zaAorKysgYi90b29scy90ZXN0aW5nL3NlbGZ0
ZXN0cy9uZXQvbXB0Y3AvbXB0Y3BfY29ubmVjdC5zaApAQCAtNDQ3LDggKzQ0Nyw4IEBAIGRvX3Ry
YW5zZmVyKCkKIAlsb2NhbCBkdXJhdGlvbgogCWR1cmF0aW9uPSQoKHN0b3Atc3RhcnQpKQogCXBy
aW50ZiAiKGR1cmF0aW9uICUwNXNtcykgIiAiJHtkdXJhdGlvbn0iCi0JCW1wdGNwX2xpYl9wcl9l
cnJfc3RhdHMgIiR7bGlzdGVuZXJfbnN9IiAiJHtjb25uZWN0b3JfbnN9IiAiJHtwb3J0fSIgXAot
CQkJIi90bXAvJHtsaXN0ZW5lcl9uc30ub3V0IiAiL3RtcC8ke2Nvbm5lY3Rvcl9uc30ub3V0Igor
CSMJbXB0Y3BfbGliX3ByX2Vycl9zdGF0cyAiJHtsaXN0ZW5lcl9uc30iICIke2Nvbm5lY3Rvcl9u
c30iICIke3BvcnR9IiBcCisJIwkJIi90bXAvJHtsaXN0ZW5lcl9uc30ub3V0IiAiL3RtcC8ke2Nv
bm5lY3Rvcl9uc30ub3V0IgogCWlmIFsgJHtyZXRzfSAtbmUgMCBdIHx8IFsgJHtyZXRjfSAtbmUg
MCBdOyB0aGVuCiAJCW1wdGNwX2xpYl9wcl9mYWlsICJjbGllbnQgZXhpdCBjb2RlICRyZXRjLCBz
ZXJ2ZXIgJHJldHMiCiAJCW1wdGNwX2xpYl9wcl9lcnJfc3RhdHMgIiR7bGlzdGVuZXJfbnN9IiAi
JHtjb25uZWN0b3JfbnN9IiAiJHtwb3J0fSIgXAo=
--------------zsyLijCwJt75mnZDJr3wXu21--

