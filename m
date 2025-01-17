Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0919D892
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 17:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737133310; cv=none; b=oIoy2iR4yEcPGHyxPX/DMJ5jvzLPIJVTdkOnGNU7RDLjZ6f6udiCLxwga2f1vsDtcUH442/ub9p96x9j5i7GM8x+539nuIK0wpq5fOio85GwLju74XhNjdVBLg8zMT0a+S/BWRsPLmbfFWeRhuTZk5oZ8WECgUgo4xKqXdIXKFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737133310; c=relaxed/simple;
	bh=3Xj3t5nn9e4wjFDYn3tVqLMDG0fYkTR2lx3sH48RcsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=U0bIwANJHteuIoeRysj7yl7XSlG3Ad76yoqlXuIyvIcAVYecofhNekmgYffJNa3Ved7xWzufro1qvT6Izn1CJBYnwYRkFpSL9MDcBIsdHl6SpgQzDXflsXY8/DyqLFwdPLurbvzfGafJsywQhnLLVPJWHe1AIZB9OQKr0bIZATo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LcPK2jwm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LcPK2jwm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737133307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=b9w0itPnhLXdz++z/K63rWFwG/mRLmfEa8BLhdj6Po8=;
	b=LcPK2jwmHEuK2N1dqwii8FoVEXbO2aoqLE7YU42WeDL63SJzgdIXFR55l9ZDp0FAi+HOQ5
	FCofd01xXOFUdnNxp+LoYm0bQPWpOSYit3uL2WvgXIQwt/n18rVazX0nMsvd+1eQ7IxseC
	JPMU4AzqJPfsESwDLFkWNcoLoPUkPso=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-pqjIFUu_P-qzpsg07JMa1w-1; Fri, 17 Jan 2025 12:01:45 -0500
X-MC-Unique: pqjIFUu_P-qzpsg07JMa1w-1
X-Mimecast-MFC-AGG-ID: pqjIFUu_P-qzpsg07JMa1w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-436723db6c4so16876675e9.3
        for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 09:01:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737133304; x=1737738104;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3Q0ZXxkC4N2O25sLExzL9biJmOen8eY0G6kLH2oNAlw=;
        b=BDeMQO2lkojSgIrHJa/qNq36LsO+fetYXzMnCULbc+Er8xiaH7kgopKP0iuMD6EIfj
         lJGM2NTVHFQcsudElnASoPO/4ddOU1yZpRbbmhpBqO5O8LlbdPQIW57WlROjo+9+7erA
         0THUYgsX/hGa7e+9Pg1csrlkoVeB0swVtrx9nZ6tVcy3UzdWoIo+PkLtTqadYAKMxEXQ
         64Wsen2abWA5RUAC6zfTwhaZxVzwuMWK0ldKAzga8SrpmaM7jjkszNW9zizpJFrpL6/K
         FyKPLQbp5I02RzhFJvz1c3OFljoIQGEe9UQf+OYIGItVvIVVOaLWpsDJAoZDnIK+Hxt5
         nN5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzdsEmLxx3ITWQFSFqo3LWPeBQnCqkalqbj29b/44REVwnUfqB7t+z2JOU9mN325PQgd3JVQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxci8KON/lKYva4bj7qkL3jLGBcWpuQyiVX3gYXHtnPNH2KzTn/
	nGcwFtdXWHCaO/TCBko0nmehV/R84+5SfWcR4BYQJMgHF1Z0H30g8x7LxNj7iVDI1ogQOlTQUO3
	o39TXcjaakN1rnDdNMYGcHL56KUZUBZGOyxCiYOS0nfRhjCDx2a4a
X-Gm-Gg: ASbGnct2/cZOzRBuTL6vcT2kuQ1fqDYoc2qMmevELeO/fzIuPnmkqXX7ePoiQooIz2o
	RL5Nz358Bs8budn5AhZiPL5u8nG8dlMLxLoJRN0Rt5E53iCMYX62Pg44qmnE/CJeOpUM7xjrnXK
	F8uR7+hkKKN6+9Q2jB01Hx6/Qp167IXm8yNJLhs3cgM069m5+SpneK5gDI54wvoQ8XuPmBDmPxG
	Y+oNGNiUSey+h8HdfduTMoSgY1fHYJMJM2Z+6+detfUhXAhMscaDQ6sVTQR+zITjIxPyrejogcq
	TBn8Jj8JPZo=
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id ffacd0b85a97d-38bf56555f4mr3168326f8f.5.1737133302971;
        Fri, 17 Jan 2025 09:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE+gWUxs0A9tdilaf0k8FT76TRqrqIZ7JEg82rVAPlJvSGlBWlxaUaRbuHG+WKr2Qsbxygt/g==
X-Received: by 2002:a05:6000:1acd:b0:38a:88be:bcb5 with SMTP id ffacd0b85a97d-38bf56555f4mr3168126f8f.5.1737133300908;
        Fri, 17 Jan 2025 09:01:40 -0800 (PST)
Received: from [192.168.88.253] (146-241-15-169.dyn.eolo.it. [146.241.15.169])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38bf3214c5csm2971915f8f.8.2025.01.17.09.01.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jan 2025 09:01:40 -0800 (PST)
Message-ID: <66fa6c80-4383-479d-b17e-234bee6ed7ad@redhat.com>
Date: Fri, 17 Jan 2025 18:01:38 +0100
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
To: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>,
 mptcp@lists.linux.dev, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <67605870.050a0220.37aaf.0137.GAE@google.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <67605870.050a0220.37aaf.0137.GAE@google.com>
X-Mimecast-Spam-Score: 1
X-Mimecast-MFC-PROC-ID: hYZyRt6-6QgHxuoNkMcDuU2oafAsaoXaCCtbhvzosBw_1737133304
X-Mimecast-Originator: redhat.com
Content-Type: multipart/mixed; boundary="------------V0dHquHNhoNq0Eokc4Xl32xm"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------V0dHquHNhoNq0Eokc4Xl32xm
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/16/24 5:42 PM, syzbot wrote:
> syzbot found the following issue on:
> 
> HEAD commit:    00a5acdbf398 bpf: Fix configuration-dependent BTF function..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=148de730580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
> dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d82344580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179654f8580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/fc306c95490c/disk-00a5acdb.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e17d5125ee77/vmlinux-00a5acdb.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/65f791a7fd14/bzImage-00a5acdb.xz

Trying again... Mat noted I actually forgot the actual command

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git main


--------------V0dHquHNhoNq0Eokc4Xl32xm
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
--------------V0dHquHNhoNq0Eokc4Xl32xm--

