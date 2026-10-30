Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793341003;
	b=11zvuKaMzho4yZCBBt1YpCTpC7v2YBErmltCwhs/nzxZVhZccr49flJAfehf9kJNPWfW
	 6vzrHNRk/PP1VcPhinfGn0g7rF/6Ti8LbHLLq7u1q/4hRM5VwYyF/qUPKaM+0GnOdfJje
	 bJvP76yxJRjsl8CpQqMCP27gKgh2Le2G38zufBh66m4cLlOVtFTYeiKmPPgsOw/gzVTNm
	 wmwi1AjfkSdbVxe/HYJl6MXAwHkaZrxEzNrThFOd1KBanZXzY0e0BwprmnoBik6ThGxbs
	 rAuTAcLNo+3GFsrdXFw/0O8dci25kSC2IAIdaCpRLr0M3z0QDExxzhdmF5eSkFFsqMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793341003;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=ZDOTvYVUgH1TDZBi8krhEOv63SjN7ad0BCTkF/4cg9A=;
	b=huEYAjms0fN5s8FKJcS+4+cNszPPpZorxSP6Of2JwMaLcqzHhypZgaq202zZ8yOplVkL
	 QHw+9lFRu0jreShcZilE840LZdW7rhGYqtV23YK6+Va9rslAw+JApGZDn+Mc+ZS7f11z7
	 +quUerwcFh21yZn+KKxPJMLK0HhVma6cH94ElyajNHDRqMnd6FZvfborcDYJihZ13kIGR
	 Zz1HInfPN+TDsWGglKw8ftBg9yhwQH0zrtPXtcv4YblTPekny3IMfe6qNNrlrUn9JnZnj
	 zcahZ2g8nPrBS9i/vW9QqIPpm5vPfAeaBcpGw0+Ri72PDDsnU+e3sA/Nqu9vlirDFaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvOcsYHB;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF8606A324
	for <mptcp@lists.linux.dev>; Fri, 30 Oct 2026 06:16:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45EF8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lvOcsYHB
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-4a77dcc4ca0so190001fac.2
        for <mptcp@lists.linux.dev>; Thu, 29 Oct 2026 23:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793341002; x=1793945802; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ZDOTvYVUgH1TDZBi8krhEOv63SjN7ad0BCTkF/4cg9A=;
        b=lvOcsYHBTO63RyGGNqePwBBJQeutm0v9l4o1h4+f7jxkS2i/CAZHYQ20TZPo1vXv9u
         A/FQNbFNyh9UvIf3f9k94NShwJdyr27j79Q6JCiekDwseMNt9PUw+pchlFYzZBXQLsPX
         CA9r7l7S1BhUvY++PGWiVcgdcQrCEUM+S+d9gwqwjeg9xlFaxwYl2jyrKCrWdIZFwLJz
         5+7L2mTgFcIBaGr3flQSMEzyOLb/SE+0g9cfff0XbyMbZwG6JDqdgGukMJ8c7mi20CFn
         drf4kp+V0Nsos0QtF16WdtvljnWULFMatmRxN6bKeA6dbjvMJU7FESmsUxk+lZ7szrwR
         v4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793341002; x=1793945802;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZDOTvYVUgH1TDZBi8krhEOv63SjN7ad0BCTkF/4cg9A=;
        b=OddKQhB1t3yBHJ340eEYLKc9T/YzfT5xHVlTC96iImt+rZXqVZULgb00okQJNW3NZ2
         4Av6wL3VKfbXULYV88SoKfB7KZ8zMDYJioVmwKaciQTFVJQTWe7bbHlVs/nbN/ZOY4dh
         3yWOU0ZbBZfvJQ5hONGvRsE1FAE5jGd7eoIM+d4C/PK0BSwLechWBW+cij9p4ldTWhYp
         P1F6IGB6fGc0Fuixr5Jbc2JVyjETYy9Z5BVVUHa9ZC6cCw7YJVg+KBTiHZoKxtrWWdPK
         r/h3C6aOVKG3w4gTa88lw4MQlwJpcfRXAyFe86A9itzxyNfcMZozzrY9GSRIr47WX870
         9w6w==
X-Gm-Message-State: AFq9FYIf2+jr32pMv3C4B/PxvAVL1WYXAnziW7jATmEU7uLq4Wu9DHq3
	AMJ5t3UbRoRWl9Ki4RIeV7QIbDeOdJyNKM50Hjs9NY+nKL9Y/94Ug2g=
X-Gm-Gg: AYBFou2e8/WNDBihZgGTIeA1ta5aILyfojtTrX7WfFnP6R09gZdvuRKx8MvzxsW/2/v
	Mv4wNaH9Uj3W+V1gmy42gaF3HlrufbI6Jv9NfI3ihieLDq6GYdRuqXYG+qSJJDshFBfxXQHWzwm
	Q9neaUhltEcK4jLx7KTUBE1r/rqrVajMD3JLLpmQ6kt+VCSjHSIiQm/+rhCT/+A8JVvjqUWqJxO
	wNf1N0TFBUkRgAPruxmf2e15oY+DlrQxwobOYWHutZ+5JYhTb7ZIopCU8G1PfLtB+0j47s3qOmg
	l13spNKXoPMPn+uXimleAgdwFw05A+r77cop34OyZDyzIYLgLLnoO4FrofiM0BTkY3lXnOUz8Tl
	n7Unz4mxGRi59EyAKGKtWR4zS88QWjRTr+IZ/1rE/W5gaUXMjOYqeFfN9IlYjusBlNGN6FUtsNm
	T9CqeBvDSzlCcjbTd7SBXypiUqtR/ddoHCGkIXaoNlhRWtiLGezzDVQ/eY/hDQCVt4m7HvHJzn+
	y4rYUrahxvOFAMDBo8IriJHph/nqw4BSAwxy1exYYy2St88yg0rwKt6F8UAfNvMejMANTyDJwLt
	271CKA2zniW2CPDhX/M28GTcmITN1m2zqvQXT5O09Q==
X-Received: by 2002:a05:6870:d626:b0:494:93aa:9212 with SMTP id 586e51a60fabf-4a9078421b7mr889192fac.51.1793341002100;
        Thu, 29 Oct 2026 23:16:42 -0700 (PDT)
Received: from github.com ([20.186.238.33])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a90aeaa9e0sm1000068fac.7.2026.10.29.23.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 23:16:41 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Kyle Zeng <kylebot@openai.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261030042255.74216-1-kylebot@openai.com>
References: <20261030042255.74216-1-kylebot@openai.com>
Subject: Re: [PATCH] mptcp: pm: kernel: use RCU to free endpoint listeners
Message-ID: <d3ddec02-ff99-d3d7-74bc-248b002a091b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 06:16:39 +0000
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

Hi Kyle,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/41004800864

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/e7fe1385ce=
91
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1196811


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
