Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A127280A
	for <mptcp@lists.linux.dev>; Mon,  4 May 2026 17:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915897; cv=none; b=BUtwZNLqZWHPhjUW+f9KQ2Tx0MXUQzNmiz1NT454wHL6PEjBdh1ICZmXVmJLMvrcalFVWGwGN/I5ZR388zqbg2lsn1POktSJphEHFmWpaLqSlCRz6u08I+Ocletih7HMx55RYh+a8lXZTR42J8cOTCyoqDyulvFCKhJq4eIV9w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915897; c=relaxed/simple;
	bh=2YKq67vR99TygPJ/FRtiFAG8tNBq0uXLJBy6w+zgBp4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NYKvQg//ADE2qWDj3aTWwF/DVgcOTuMz2IaZEoUOfJhGZLzymmyDvpiOiSjJp8HcEWA/dXslB/b6ijjXhSp6NPID5Iw13vDx8I2Obqfg3pKxHF1AqkIm2OvbArP97EA9Fc0OBWhg8FDFR+aB78L+19rGFrG6aCa7Kbc+BhkQyZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkIsvcgi; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkIsvcgi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777915894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPkZ/ob2YfaxRkx1lnX+QZmm8ENLmtA8VtuLuZpN5fc=;
	b=MkIsvcgizgDcE/N1DHe1esO1IcSiQnLTV1AgImitmQ918cYNQGaQb0xj7z4OtaA5WPtazN
	9h7d83Xt+mfAzv+BVQSSbO3tosHHLiayhnchz6987C43CcBaRdxKyzoxtKJt4IqfCbzykF
	HV06SAtsCOctp9hUfSFwPMTf2kYXLbg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-sLtNWRnuNmGkC5EINd5vJA-1; Mon, 04 May 2026 13:31:33 -0400
X-MC-Unique: sLtNWRnuNmGkC5EINd5vJA-1
X-Mimecast-MFC-AGG-ID: sLtNWRnuNmGkC5EINd5vJA_1777915892
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-488c0120047so29645425e9.0
        for <mptcp@lists.linux.dev>; Mon, 04 May 2026 10:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777915892; x=1778520692;
        h=in-reply-to:content-language:references:cc:to:from:subject
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YKdfwZg1j64pbMDLEMzUhRDyZxTJINTCywCn4S5j9WE=;
        b=LqzHReEo7dg1z/l5ff+/nsdwK9mQ9DQIWubmN2j91ISUJ70lcV1qzIRp3ZEBUXM0ze
         +R5mwLT6ymofnpF92XCbUgn0jGxJa6s1eOiIMrpm71ffxSffkT45GjVx8z3PS1z5qKyE
         GWEQTewOzHwTy8hAYINL0cYUFRy5mskxKwX4iY+wZJEN4kOFFjACeDGHg47LAuxjd0tK
         BzpsGW/CdTus8A8KfPEeGWEX9fXfEIYMuSPVbpbnC73FdpI0lwph8x8Po+gb3YdklEcJ
         NCXHorIx6LaIPpdL1hqh9HSfoJ486mY3KmkQyS7i0kKEv5G9zAePkoB2GZwodqH3oLud
         Nunw==
X-Gm-Message-State: AOJu0Yyr3m2KmXiwfaL0usbfCc3HcD28zpmW4mFHKvmL0MHSxjEUILFp
	mn7UwFiNkOtJEd7NyI2Z2u7eWYHl7+Y/aFlp0IfZXsf0tG5KNgLY1DQ2KfPbPfjgN/ygxb+T2xr
	A0sMSEbKp97vFKFXYZmH0NBfITABtS4rWOWO3av5CBE/4UHRmKzcKQWJ5TP3xkbvMUKek6sfkEs
	lc14qmMwvJumxpmKRkhKtGbmcpfaSDt6pA1ELBqw==
X-Gm-Gg: AeBDietyq5JdWSblav6OznRca3vVGlO6lQwYh0I3/3e6iMS1G1sVTrtBfXwXXTPm9GW
	SjxdujYcyi2APIYgskHj4Du9rL9uMgYZR11cpZmImU5EBsF4GEg4ITLw8c2CPI5P5YWfA5lKg+1
	L7SKAZc4X6OiInyV3hWDq/aCpI08U3+pfIr8Hho29hZ/ygZ8LK5JOBZlaQ8zuld1Q4DUfEjBgrD
	cIDZIOxBJdgZIZn1VxH0RVPZ3BJxU9JXtE6kWcaJU/FL03LYHdUOefsUc/RE571VhU90je/JOLd
	fdAbt/9xq/PcPDjgkB3xGxgCZ0KUpPuIuA4P+/9yShQ9cxo4CxKj9WZDqySMYk378PG/nQxzT3h
	TumwGJHU0oDfG+vQRGOUNqxlEBMWvXMyJi6xYwQoDqXBaTcGQihb9AHHldVoJs6zAsQ==
X-Received: by 2002:a05:600c:c171:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-48a9865d9b6mr201285215e9.14.1777915891671;
        Mon, 04 May 2026 10:31:31 -0700 (PDT)
X-Received: by 2002:a05:600c:c171:b0:487:55c:e0c1 with SMTP id 5b1f17b1804b1-48a9865d9b6mr201284395e9.14.1777915891074;
        Mon, 04 May 2026 10:31:31 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a81ed69fasm405201745e9.3.2026.05.04.10.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2026 10:31:30 -0700 (PDT)
Message-ID: <024e0baa-a16a-4899-ad51-249868c1967b@redhat.com>
Date: Mon, 4 May 2026 19:31:29 +0200
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mptcp: fix KMSAN: uninit-value in
 mptcp_established_options
From: Paolo Abeni <pabeni@redhat.com>
To: mptcp@lists.linux.dev
Cc: syzbot+ff020673c5e3d94d9478@syzkaller.appspotmail.com,
 Kuniyuki Iwashima <kuniyu@google.com>, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, Matthieu Baerts <matttbe@kernel.org>
References: <69f44505.050a0220.3cbe47.0008.GAE@google.com>
 <20260504095101.852039-2-matttbe@kernel.org>
 <67030b5e-0435-49fc-8adb-8dd8536ad853@kernel.org>
 <5841afcc-13ea-4bee-8645-634a02e76c4f@redhat.com>
In-Reply-To: <5841afcc-13ea-4bee-8645-634a02e76c4f@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jmmw0I1adtEX4FUZ3jDb-yG1NXwZA-FUSnHlzGBZrlk_1777915892
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------0No5wcanRS9ZVJZvIYlNBmuv"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------0No5wcanRS9ZVJZvIYlNBmuv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/4/26 6:22 PM, Paolo Abeni wrote:
> On 5/4/26 11:59 AM, Matthieu Baerts wrote:
>>
>> Sorry for the noise: I forgot to add the syzbot instruction... (and I
>> forgot to remove the MPTCP ML from the sendmail.to option).
> 
> I did not take in account all the possible corner cases.
> 
> Let's be a little more conservative.
Darn... the last upgrade here broke the line (un)wrap extension. Let me
attach the patch. Sorry for the spam.

#syz test

--------------0No5wcanRS9ZVJZvIYlNBmuv
Content-Type: text/x-patch; charset=UTF-8; name="zero_opt_flags.patch"
Content-Disposition: attachment; filename="zero_opt_flags.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbmV0L21wdGNwLmggYi9pbmNsdWRlL25ldC9tcHRjcC5oCmlu
ZGV4IGY3MjYzZmUyYTJlNC4uMDc2M2ZkNmY3NzU4IDEwMDY0NAotLS0gYS9pbmNsdWRlL25ldC9t
cHRjcC5oCisrKyBiL2luY2x1ZGUvbmV0L21wdGNwLmgKQEAgLTI3LDYgKzI3LDkgQEAgc3RydWN0
IG1wdGNwX2V4dCB7CiAJdTMyCQlzdWJmbG93X3NlcTsKIAl1MTYJCWRhdGFfbGVuOwogCV9fc3Vt
MTYJCWNzdW07CisKKwlzdHJ1Y3RfZ3JvdXAoZmxhZ3MsCisKIAl1OAkJdXNlX21hcDoxLAogCQkJ
ZHNuNjQ6MSwKIAkJCWRhdGFfZmluOjEsCkBAIC0zOCw2ICs0MSw4IEBAIHN0cnVjdCBtcHRjcF9l
eHQgewogCXU4CQlyZXNldF9yZWFzb246NCwKIAkJCWNzdW1fcmVxZDoxLAogCQkJaW5maW5pdGVf
bWFwOjE7CisKKwkpOyAvKiBlbmQgb2YgZmxhZ3MgZ3JvdXAgKi8KIH07CiAKICNkZWZpbmUgTVBU
Q1BPUFRfSE1BQ19MRU4JMjAKZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9vcHRpb25zLmMgYi9uZXQv
bXB0Y3Avb3B0aW9ucy5jCmluZGV4IDhhMWM1Njk4OTgzYy4uM2ZkNDBkYmZmODJiIDEwMDY0NAot
LS0gYS9uZXQvbXB0Y3Avb3B0aW9ucy5jCisrKyBiL25ldC9tcHRjcC9vcHRpb25zLmMKQEAgLTU3
Miw2ICs1NzIsMTEgQEAgc3RhdGljIGJvb2wgbXB0Y3BfZXN0YWJsaXNoZWRfb3B0aW9uc19kc3Mo
c3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAqc2tiLAogCWJvb2wgcmV0ID0gZmFsc2U7
CiAJdTY0IGFja19zZXE7CiAKKwkvKiBaZXJvIGBjYW5fYWNrYCBhbmQgYHVzZV9tYXBgIGZsYWdz
IHdpdGggb25lIHNob3QuICovCisJQlVJTERfQlVHX09OKHNpemVvZl9maWVsZChzdHJ1Y3QgbXB0
Y3BfZXh0LCBmbGFncykgIT0gc2l6ZW9mKHUxNikpOworCUJVSUxEX0JVR19PTighSVNfQUxJR05F
RChvZmZzZXRvZihzdHJ1Y3QgbXB0Y3BfZXh0LCBmbGFncyksCisJCQkJIHNpemVvZih1MTYpKSk7
CisJKih1MTYgKikmb3B0cy0+ZXh0X2NvcHkuZmxhZ3MgPSAwOwogCW9wdHMtPmNzdW1fcmVxZCA9
IFJFQURfT05DRShtc2stPmNzdW1fZW5hYmxlZCk7CiAJbXBleHQgPSBza2IgPyBtcHRjcF9nZXRf
ZXh0KHNrYikgOiBOVUxMOwogCkBAIC01OTUsNyArNjAwLDYgQEAgc3RhdGljIGJvb2wgbXB0Y3Bf
ZXN0YWJsaXNoZWRfb3B0aW9uc19kc3Moc3RydWN0IHNvY2sgKnNrLCBzdHJ1Y3Qgc2tfYnVmZiAq
c2tiLAogCS8qIHBhc3NpdmUgc29ja2V0cyBtc2sgd2lsbCBzZXQgdGhlICdjYW5fYWNrJyBhZnRl
ciBhY2NlcHQoKSwgZXZlbgogCSAqIGlmIHRoZSBmaXJzdCBzdWJmbG93IG1heSBoYXZlIHRoZSBh
bHJlYWR5IHRoZSByZW1vdGUga2V5IGhhbmR5CiAJICovCi0Jb3B0cy0+ZXh0X2NvcHkudXNlX2Fj
ayA9IDA7CiAJaWYgKCFSRUFEX09OQ0UobXNrLT5jYW5fYWNrKSkgewogCQkqc2l6ZSA9IEFMSUdO
KGRzc19zaXplLCA0KTsKIAkJcmV0dXJuIHJldDsK
--------------0No5wcanRS9ZVJZvIYlNBmuv--

