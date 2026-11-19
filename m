Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795125349;
	b=NZW3Hjyr+YW3owjVE71hIIaDBag53bMnGFEWLvwOWfJUHMcEexsJlG96jcbddihSD7uG
	 6tqZnAbRtqH8kjn5YX4GeoG3fkJdPoglr3qdfoiNuz3J6GU+HYsiYUnli977eNnD5dcfE
	 HmRW1tUEJumXM15IFHPDH1ZhcKEqDB2s/D15hzM+Rha8QKXtgPyCcXbdlJC76WKm0BURi
	 MZwrnOsdx/GO1joNvA5DJGKXxf83zYbd/8VcwBLdhEn+AccZVIQ+oJoUpkLGKQcux5e8k
	 8vxq2tthdv0SsAfmF8vPYcHrD0qWQ4QHMbxzgeFq39K1QQwo1GshTCH6pAtL3BDqNkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795125349;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=xVYHgEeO62eBbtaH8d/LKvgTYdqe1NyIrewuc65N5tE=;
	b=lS7i4hfh4VI2iGSX3CJLxi1uBvWWvuRCeiy2Dde4QYPQwTB7sdiyhyeDmPi3Gbqv212g
	 o178Y9IGpqE044dipCxEgDWmxk6sNNAkLd0aArFlIiedonkp0etsTpXS7aXJ72WpEI9Yv
	 ZHNxV157qoH3WNv8O0koS0aCYOwJDlEnlvfwDY4SVbHXfvsdseSU6RRrrzN+jErrGIvsR
	 8PQHeNKZDM34Ub0OmNlFQcYtRGs35LzOmM2V2skHyipDekJJnJDCZ06PMPOolEZG1RZyq
	 7l9N0qRg2zy2nU/+HfkCWNvi1fbnfX/HxVhB1oCOUfaM1XpRX3Cd10BT1xCIaiyzx3g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ov1ekfbJ;
	arc=none smtp.remote-ip=74.125.224.53
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E813606A320
	for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 21:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9E813606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ov1ekfbJ
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-675617e81f9so388789d50.3
        for <mptcp@lists.linux.dev>; Thu, 19 Nov 2026 13:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795125348; x=1795730148; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xVYHgEeO62eBbtaH8d/LKvgTYdqe1NyIrewuc65N5tE=;
        b=ov1ekfbJitjUUSSvOJjlDWYiycnF7e7MkSfWkh+6Oh45YKMUJizAs8kPbmvC6mVIWu
         /8YdvBJjWbkBVqlQ5jMPavil/JU1iXQIKB+8JFv41SQolqHM6IySw43Uk4+nvWGmoox1
         kEx+p68Pt2EbV24zzuDEPbpJAOEatQ2cc7D7T7f/CSD4BrhEPNs/R0Zs77O95CY1KhE/
         TYfu4x2a0So/g4n+hukSJghVdAq4Q+Hjb4v1VJ94y9gYxTUIt1rpSJBkxSUuSI8hm7dg
         q+kwGHNKgh1XfPdP6ZjxIp4KPuiPlcYT5tVsvixfFEfPiRIBKwga681u7mG42va853GC
         Hbnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795125348; x=1795730148;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xVYHgEeO62eBbtaH8d/LKvgTYdqe1NyIrewuc65N5tE=;
        b=QMA9ofI9uKbWqF9HFJUwx11cxAWDJi8QUBxZp+d0rHI47p8XXHo5UMo2bEIWHUrFRr
         rN/NdD33CIkrDJx5ONoRqry365lHCZRhETcOUQJDMhl92Pag4L+ZFvXw7vp4G78j1klF
         XXKfLIvnBn7JiK9aKpnHJ+8ZVF3V1HDFP0r3HCsFG54jRHt79jRqGuEXCyIR/zwjxof4
         6krRJ5ghnAoa5cvMZHpekICVzvLWE5sUZ2Y/5EIINsemx8IT5yNUDKkAz2bvYhXNjwcw
         yNvXCfF5aw80rTezfkuL8lgfSb+8HuIUYXBK1kxbosMg+Vfa+vIbMLu9uDAwlBI05uW0
         9NJQ==
X-Gm-Message-State: APuU4Z+yKglyWxgLNSTcFvpNVnXsqW2RsSuTv/vihMVLtUYjceTLY3kw
	NWVV8uGPfwulfi7x4M+RK8SYpKig16sLD1hHL1S5dutbl6gUjhvoapE=
X-Gm-Gg: AZFdTZf7zvZYdaUfnXlO+K6zQQHmsmHgcT6/rWSWLOhfIi1MOQN/7aDN38MqHTsEAPi
	lg1cklS8XL85xcE/UvuVRvHGS7wtw8cmOQLvTMhki52Aobi2XDN219/di5j/6X6gHqMP6SCjVyU
	4wRNTzTLM9UO2nOpBSzuKKj/WZan0rknz8bFMMjXxsN+WTwaxTUaK9x7aiJXhac4pOQAtf28u8Z
	VYf25IjLaSM64QDrJruzgY/KNon2sjYoJKONmbAaaMZxnZ4YQsKo3HnC8mf0WVLcmVEfIxnnB3X
	MhUEkwxC5IonBvCQQLWOwCEWVBgoYrTKn87mCNzMYfyzLMjh4HDfZ+Eq8hJw786l4kIGGq0xss6
	Nz5SYRXEA7YbMWd+/w1G3tWsmdnXpiebNbvXiSckAJ63YWQWS8XS6P4lmZ8aDWtGeYh5ZDNMzsY
	9ykYvN30gWtFsvHZiV9s1DdlgSfQPHp5Iosccef2zk3nMcDB6ddZnXmXKvfqnTOwTq6ZYJ6slR2
	Q+FWZw33hssKlW7mK+YcShxtQvGA++jla8SgxmowOtDVO+/EWBlGUUYJLVxMqxlFF0uhTywhL6a
	CEN1eN/bobgjVnkoC0d8r4V1zRVs+afD8TFSlcGfR7qk
X-Received: by 2002:a05:690e:128e:b0:67d:beb0:e484 with SMTP id 956f58d0204a3-67df43ce345mr414409d50.27.1795125347448;
        Thu, 19 Nov 2026 13:55:47 -0800 (PST)
Received: from github.com ([134.138.61.163])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5202d7769sm5846947b3.25.2026.11.19.13.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 13:55:46 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Dominik Maier <dmnk@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20261119192159.2646113-1-dmnk@google.com>
References: <20261119192159.2646113-1-dmnk@google.com>
Subject: Re: [PATCH mptcp-net] mptcp: gate diag sequence counters on
 CAP_NET_ADMIN
Message-ID: <8aeb11a0-4c69-38a6-283d-10d6c0f1e7f5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 21:55:46 +0000
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

Hi Dominik,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 4 failed test(s): regression:sched-bbr =
regression:sched-mem-pressure(2) regression:sched-rmem =
regression:sched-serverlim(2) =E2=9A=A0=EF=B8=8F  (2 improvements, 777 new =
outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/44601177439

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6d4173053b=
74
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1216597


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
