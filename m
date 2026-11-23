Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420737;
	b=gj/h8k8bMPdoyz0Sm6luhgzKbDGGH0qUVIl7+c0AW/q6N5wv4y5cOtRzb8uw7U33l1SX
	 siipAZhhHnm94/Nk+BklmF1hyz5Uy/HRU4c9dER7npmxkYf/Wv/53Lk6ABRf3R46u5rL3
	 OwS8VRyRVIG7WrjsEpbEz7m6l5W3+Z7IA4PzH0pEJ9/8JZeWow+gqj5gKrx9OYXIIslTG
	 3OtsdTNVXbtVfamEi3bM91gm4zdW0jtN/P7PoUJx4YMrjAGItoPGyVuAw7nEXjpRjL+PX
	 UkmAKuIIwm+z6DYbp5DkDIKeJ3WG85zXPG+OLjvFoko5PZ7hOLKMLX2bbqQ/cwTyOFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420737;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=YovMiXb6ANLBKOdgT65DhHbVM0qHCU5I6VzLtOUy/sc=;
	b=DicKQmg1blOqbMNAb7vsV6BfQa7V6h75RgJZ3GHVZwqLvAFUEZKbtqRQkVCkKsluNY/1
	 dic+pHYgsf3EqA1xWxRJqOEtsM0tIhfzHqo+qycujbqkSrGY02my/e4tEHt2PYG8H0hlY
	 byIZe0ZmbTuxDQOrkMn6lWjlYriloJ2zTrhBXz394hFsxZxAKfOqSGAtSeCFNE8xmXUnI
	 longTnmgsnRp9Wpf39+CSk/KtB45klOpjNSmJtSzghCsTRXY06dLPhbfq+ehj7zf/oHVx
	 AS4IHgjQPI20xr9XSW01DcdcjCmkYDHajpVgRjiHVDqjFIRMQz6jyBIg7VWLihkJpxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpKXB8av;
	arc=none smtp.remote-ip=209.85.160.182
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71351606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 07:58:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71351606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wpKXB8av
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-55c5b6584ceso23276051cf.2
        for <mptcp@lists.linux.dev>; Sun, 22 Nov 2026 23:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795420736; x=1796025536; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YovMiXb6ANLBKOdgT65DhHbVM0qHCU5I6VzLtOUy/sc=;
        b=wpKXB8avmDvVMkRsp5Ltf923X1NtBeVkgFxrW7F2L6WC/+EaNdNyMqBuikuO+wL8cb
         IB/jGLo7syd9RpewT6MrA9pANtTei7ln9Jar9/6oOOlpKIK36H8r7lEgAuoPJxBUgIIC
         FQgTQ66GIud6iZ2LReg8fXnVkUxwB+SEUoOoGPydelu09APqzxiOvv1exoezhuRV9nn3
         9qmdzsnn+t7xe7Jkg318dDHR5UgBCrrJi2wmHjcb9Oj9qwZh71PB27gEDWn54KyU/xpI
         vPV0TY250JoBh67xplsN37BLHv/3r5IBx7XvL8sbRM1pYGLD7MdVLg3nE8jVHjQtpWyG
         gjuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795420736; x=1796025536;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YovMiXb6ANLBKOdgT65DhHbVM0qHCU5I6VzLtOUy/sc=;
        b=UAK9Rwey7+841WYKQZKcEAsYPjJi5admktxpLCmiz+YOarMHZ1Yd+Ts3vjGpQmd2uH
         Zjg08zi2PZSNN6yuaJnegdCGj1iKxGi1quMbdfk9uGfJn3dpYUGPCoc12aFFSs3kUonD
         cvTydYivjILS/T6kY8Y7dCQrPAjuBEXYh0TfhYLWrdVoV573jhw/dGAVsxSSKxDR2ySk
         wDrvWs4+Z6g0EO73xh/lMgCyjqnZ1C1alcVykVtm9j837mc16DXWaWoEO9ukV5n/f33B
         fRTcy6+44ALU/t7TjDaFa3W+Zc1uqkSDphYNNVXTlCBesKaZjRjrZNgqdm5yImZFd3My
         cwvw==
X-Gm-Message-State: APuU4Z+ib9d8xgRwqdfCna7F5RxCY24gIb0cdCZ9yJUwfnRrC7Zx2SZn
	jG3Cu5wbP2CFEJccPH+JjOvLn7BgBK3sxZkxk2zuZV0ueJlmq6tFJaJ9uz8M9JE=
X-Gm-Gg: AZFdTZfil9wZ0IYXCfEdaDzxvM8W5QD1cCANnBn2ouHAkv1oEQJXU/uIQCDkQG3OFyz
	apSUCrN+pDb0N9CGd/tD4Ek+thgxsvZTDbCIKviQIRm8oGMrygeipIjDg271TQ49OmzBQKtHTZ2
	rX2oFnUOLvRjVAgpyECy7qDHlrqS0IJGVvgnmQroq1vWA3zn5rc2bYe9GO13pRu7QJfs91a7WQG
	GSMqViEouynCIsniTfGpyDM+JqE3bEUTTsbaR12Yo2/A2JE8At9cjEFp4hGnoSpgFmbXvDzGsDV
	TP1I8kvV1S9YeFv3vDZyhkqmZr6EMe+JsCnqK6tgHBFj0TS/rOkh7uJ+Z7IeRugNyL9TnliO72L
	lDFqgeInvWawwln0ICMdNDKpMN5fhAO8xafh3V7FRWqiQiXMkaG73ZqMEuUWR6o1YvFF7DeqKKw
	wKpkFWCz/Inj669ykhIshIQVO0Y2DOTzWWC1q3ObAyhDv238qrhKsX76qJl4lWuk+LacaUmUy2z
	Vv+BPl9t2+vgNr4lCoPq4qjfsohfHlcs07R5sZyiTb8QlsF4W1OwEqxOyIZCzK2kY3Nrkk2aJUC
	chfhCA2PqEDAMroKyuP1BJnWXOLfjAEdmyAGyV1pYD7oF+qFG9PhfJtEXmXjO/g=
X-Received: by 2002:a05:622a:e3c9:10b0:55d:944a:8fe4 with SMTP id d75a77b69052e-55d944a96c5mr54610601cf.74.1795420736222;
        Sun, 22 Nov 2026 23:58:56 -0800 (PST)
Received: from github.com ([172.206.23.56])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-55d788116c9sm93091231cf.4.2026.11.22.23.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:58:55 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kalpan Jani <kalpan.jani@mpiricsoftware.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261123054324.561321-1-kalpan.jani@mpiricsoftware.com>
References: <20261123054324.561321-1-kalpan.jani@mpiricsoftware.com>
Subject: Re: [PATCH mptcp-net v14] mptcp: hide sequence numbers in Netlink
 diagnostics
Message-ID: <ad89f3a0-22c5-6abf-85af-b36524337686@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 07:58:54 +0000
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Post: <mailto:mptcp@lists.linux.dev>
List-Help: <mailto:mptcp+help@lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
List-Owner: <mailto:mptcp+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Kalpan,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 2 failed test(s): regression:sched-baseline(4) =
regression:sched-serverlim(4) =E2=9A=A0=EF=B8=8F  (4 improvements, 105 new =
outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/45121968870

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/a83e39a560=
4d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1219194


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.com/multipath-tcp/mptcp-upstream-virt=
me-docker


Please note that despite all the efforts that have been already=
 done to have a
stable tests suite when executed on a public CI like here, =
it is possible some
reported issues are not due to your modifications. =
Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 =
Core)
