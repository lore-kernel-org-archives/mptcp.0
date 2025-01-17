Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B24933062
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 15:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737129283; cv=none; b=rTdIbxOPG51joiVBm0S6yCYU5OpoKZP1d+oSaMyXJiaHkbY15qRI20YuO7pFgpA4LKQE5mypU6+N/HsFhvGQg2yf0mgBzhwgezp5FVRE0tm+/88e66TQL/Fg3f62vQ5AM+ZzYrBU0P7Lwg2qrydP3rzupE3EwKhDt6VMnVPjFh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737129283; c=relaxed/simple;
	bh=NC9y5JcAwQuXUSUvYqjIY4pcH05uYrqPIe0jy0L/wcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VbqCjPgCjoURqBrI21NRHlfLEtydHH78jLwWMUsWyTSNT3jMfKIIzYeBa+5sfldXC2/ePTFQqYXVmpfbtT52rLkkqSQnGiLmUZfYTQpIWfixS6GMAOkTbU8nDyMehWVFC1NuTYC8p+gWJLFcnVHCny/vXG0MCIACBicdlKft+TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RBJaJzd/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RBJaJzd/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737129280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D4nxdl1cnyDypMUmUIKcAtQclBpiXG5+XSrLTGhumHw=;
	b=RBJaJzd/ueoHT6fMAxWkQUEtINsU3S6JqLA9IWb+NIEthk56Y+I3umpcDBBZXEdtRyOmgm
	f64tdVieZHFKsHynO2gkXQxtfJubUqpvcfBYqUIWwENgCmO11n7QHYV6iyPBcqwDm7QPBn
	ph6Y6IWCVEAmjl8pDhdKDu71a/Q9Ukg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-O-XuHdQxNcWUtYoESn08qw-1; Fri, 17 Jan 2025 10:54:37 -0500
X-MC-Unique: O-XuHdQxNcWUtYoESn08qw-1
X-Mimecast-MFC-AGG-ID: O-XuHdQxNcWUtYoESn08qw
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361efc9dc6so11592255e9.3
        for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 07:54:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737129276; x=1737734076;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8xEOdumKlte1BrryYyr+zYO6TzhDDk4EOI6NsZlx+1k=;
        b=CoYsKom1wIO1BPL2Fse2iTHj/SLYfJhBkx6/V+BuMI5ov/897aKCAqRo9m4N5cQvtW
         tebjS0MjdcCz3TKg+p5NbU2A0AMTEniwQFacDfG3ETyBI6dWBan3TwRc51xw7lI5PxWb
         Ksb5nMaL+8hCa0g5wS5sjUzh0WHguPtJxUkQnw5gw973ajPf2eScoNTLG+59ZBaerKbN
         x4xGHnS9zt1Vaf87VMJq28IhT3ykRetwZ10dZaQ2Gq545TzvwoM95AkOt6rS8O44QMjT
         Q2gbAzbGbxGDdhsW0CmbBDEQB5I15+O3nu7zRflF/AENsyxk9iBVv0rj87oJjL/YtLWg
         MyOw==
X-Forwarded-Encrypted: i=1; AJvYcCXrw8+SuiPcPWn/E+7s54j7GIypsoEllhFUhGmooO3EoOhZterXSUu5z4Mmc+6EcJCZLMIwbg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyemNtw6aBGmv9tzy3nNFxqpq2peb0O/0mJ0WEY9foYCSMC+bJH
	7R53dJ+oKKitwG3dS+INzo63HfI4yaSZuaYBOwTPXpEMT3w5sNMtRS1ArvYk891jt5cf+fI7OGl
	nvwDDhfnMSZaHNgZCUiRXjvVAEVvqcEgjEuDeEqMK2MycHkpSNcmD3MmBoKJl
X-Gm-Gg: ASbGncs11bPlh3kUgFq0LtjtRiFdasSGdHqoeJ8bgrddL+SgQ2nzsvSIWStYrGvVye3
	b/cevO5wZ6YK9RdyzRzO7Iq9QKLhjQ+ryNEF1GYpX8/N9V9mibeCaNR/yEv3b4RqFnhR8SCoLPL
	8K1QpREcrbgko1grJavKb1wmDZJQJoE8aUnxIgloXkFPtjVzMdj366196+y5WqjsAl2FptdD/z+
	nbcxoX5fN/WuCfMrlHg1lxwOmF2MVgOLQDaf4FieQBRHsIlrXWY/BN6TigkJ+vnp3x0VoHWSW4O
	dDap2aAEWks=
X-Received: by 2002:a05:600c:1d1d:b0:434:faa9:5266 with SMTP id 5b1f17b1804b1-438913e79e2mr32304565e9.13.1737129276052;
        Fri, 17 Jan 2025 07:54:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsTg2raWhjyEo5lKjWgBmLN/ToD8g9/G+vx9LF2oshOtykfFxQS9zN4r4klibJsr1IWmBXzQ==
X-Received: by 2002:a05:600c:1d1d:b0:434:faa9:5266 with SMTP id 5b1f17b1804b1-438913e79e2mr32304335e9.13.1737129275709;
        Fri, 17 Jan 2025 07:54:35 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3215482sm2816198f8f.5.2025.01.17.07.54.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 07:54:35 -0800 (PST)
Message-ID: <0fcb7d4a-bdda-44f9-8f86-3e7669b65bb1@redhat.com>
Date: Fri, 17 Jan 2025 16:54:34 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
To: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, mptcp@lists.linux.dev,
 syzkaller-bugs@googlegroups.com
References: <6789b25e.050a0220.20d369.004d.GAE@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <6789b25e.050a0220.20d369.004d.GAE@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6MvKZ4W_t8WHWL3V3w-4Z7E-HrtDuo0S3CeWD2-Mxr0_1737129276
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------QMuwEC0rishas579NE0afvxl"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------QMuwEC0rishas579NE0afvxl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/17/25 2:29 AM, syzbot wrote:
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> WARNING in __mptcp_clean_una
> 
> MPTCP: snd_una 52e55b5d657ac4e2 snd_nxt 52e55b5d657ac4e2 write_seq 52e55b5d657ac4e2 idsn 52e55b5d657ac4e1 dfrag seq 3d10b145d4f45513 len 32728

It looks like we are not catching a disconnect().

Add the missing accounting and more debug, in case the problem is elsewhere.

/P
--------------QMuwEC0rishas579NE0afvxl
Content-Type: text/x-patch; charset=UTF-8;
 name="mptcp_clean_una_splat_debug_disc.patch"
Content-Disposition: attachment;
 filename="mptcp_clean_una_splat_debug_disc.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL25ldC9tcHRjcC9wcm90b2NvbC5jIGIvbmV0L21wdGNwL3Byb3RvY29sLmMK
aW5kZXggMWIyZTdjYmI1NzdmLi5mYzhkOWZjMzY5NDIgMTAwNjQ0Ci0tLSBhL25ldC9tcHRjcC9w
cm90b2NvbC5jCisrKyBiL25ldC9tcHRjcC9wcm90b2NvbC5jCkBAIC0xMDIyLDggKzEwMjIsMTgg
QEAgc3RhdGljIHZvaWQgX19tcHRjcF9jbGVhbl91bmEoc3RydWN0IHNvY2sgKnNrKQogCiAJCWlm
ICh1bmxpa2VseShkZnJhZyA9PSBtc2stPmZpcnN0X3BlbmRpbmcpKSB7CiAJCQkvKiBpbiByZWNv
dmVyeSBtb2RlIGNhbiBzZWUgYWNrIGFmdGVyIHRoZSBjdXJyZW50IHNuZCBoZWFkICovCi0JCQlp
ZiAoV0FSTl9PTl9PTkNFKCFtc2stPnJlY292ZXJ5KSkKKwkJCWlmICghbXNrLT5yZWNvdmVyeSkg
eworCQkJCXByX2Vycigic25kX3VuYSAlbGx4IHNuZF9ueHQgJWxseCB3cml0ZV9zZXEgJWxseCAi
CisJCQkJICAgICAgICJpZHNuICVsbHggZGZyYWcgc2VxICVsbHggbGVuICVkIGRpc2Nvbm5lY3Rz
ICVkOiVkICIKKwkJCQkJInN0YXRlICVkICVkXG4iLAorCQkJCSAgICAgICBzbmRfdW5hLCBtc2st
PnNuZF9ueHQsIG1zay0+d3JpdGVfc2VxLAorCQkJCSAgICAgICBtcHRjcF9zdWJmbG93X2N0eCht
c2stPmZpcnN0KS0+aWRzbiwKKwkJCQkgICAgICAgZGZyYWctPmRhdGFfc2VxLCBkZnJhZy0+ZGF0
YV9sZW4sCisJCQkJICAgICAgIHNrLT5za19kaXNjb25uZWN0cywgbXNrLT5kaXNjb25uZWN0cywK
KwkJCQkgICAgICAgc2stPnNrX3N0YXRlLCBzay0+c2tfc29ja2V0ID8gc2stPnNrX3NvY2tldC0+
c3RhdGU6IC0xKTsKKwkJCQlXQVJOX09OKDEpOwogCQkJCWJyZWFrOworCQkJfQogCiAJCQlXUklU
RV9PTkNFKG1zay0+Zmlyc3RfcGVuZGluZywgbXB0Y3Bfc2VuZF9uZXh0KHNrKSk7CiAJCX0KQEAg
LTE3NjcsOCArMTc3NywxMCBAQCBzdGF0aWMgaW50IG1wdGNwX3NlbmRtc2dfZmFzdG9wZW4oc3Ry
dWN0IHNvY2sgKnNrLCBzdHJ1Y3QgbXNnaGRyICptc2csCiAJCSAqIHNlZSBtcHRjcF9kaXNjb25u
ZWN0KCkuCiAJCSAqIEF0dGVtcHQgaXQgYWdhaW4gb3V0c2lkZSB0aGUgcHJvYmxlbWF0aWMgc2Nv
cGUuCiAJCSAqLwotCQlpZiAoIW1wdGNwX2Rpc2Nvbm5lY3Qoc2ssIDApKQorCQlpZiAoIW1wdGNw
X2Rpc2Nvbm5lY3Qoc2ssIDApKSB7CisJCQlzay0+c2tfZGlzY29ubmVjdHMrKzsKIAkJCXNrLT5z
a19zb2NrZXQtPnN0YXRlID0gU1NfVU5DT05ORUNURUQ7CisJCX0KIAl9CiAJaW5ldF9jbGVhcl9i
aXQoREVGRVJfQ09OTkVDVCwgc2spOwogCkBAIC0zMjA4LDYgKzMyMjAsNyBAQCBzdGF0aWMgaW50
IG1wdGNwX2Rpc2Nvbm5lY3Qoc3RydWN0IHNvY2sgKnNrLCBpbnQgZmxhZ3MpCiAJaWYgKG1zay0+
ZmFzdG9wZW5pbmcpCiAJCXJldHVybiAtRUJVU1k7CiAKKwltc2stPmRpc2Nvbm5lY3RzKys7CiAJ
bXB0Y3BfY2hlY2tfbGlzdGVuX3N0b3Aoc2spOwogCW1wdGNwX3NldF9zdGF0ZShzaywgVENQX0NM
T1NFKTsKIApkaWZmIC0tZ2l0IGEvbmV0L21wdGNwL3Byb3RvY29sLmggYi9uZXQvbXB0Y3AvcHJv
dG9jb2wuaAppbmRleCA3MzUyNmYxZDc2OGYuLjU5YTZlNTJmMDJhNCAxMDA2NDQKLS0tIGEvbmV0
L21wdGNwL3Byb3RvY29sLmgKKysrIGIvbmV0L21wdGNwL3Byb3RvY29sLmgKQEAgLTM0MCw2ICsz
NDAsNyBAQCBzdHJ1Y3QgbXB0Y3Bfc29jayB7CiAJCXU2NAlydHRfdXM7IC8qIGxhc3QgbWF4aW11
bSBydHQgb2Ygc3ViZmxvd3MgKi8KIAl9IHJjdnFfc3BhY2U7CiAJdTgJCXNjYWxpbmdfcmF0aW87
CisJdTE2CQlkaXNjb25uZWN0czsKIAogCXUzMgkJc3ViZmxvd19pZDsKIAl1MzIJCXNldHNvY2tv
cHRfc2VxOwo=
--------------QMuwEC0rishas579NE0afvxl--

