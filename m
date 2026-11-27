Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795764244;
	b=GGTySOkoNQM9wSOXQ42kNOxsU6mvQQv2hB96e5Pgz+zzby2eTQzorEGyDO753UKR2S4C
	 QubqZ3oQfc9kf6QZmD7ZoxYoJG7+pOZazYVzRmyovvq9o1z9yQuob8AveFBhkncbdaxUs
	 eLMo8Qx2dhxzH+fhBoipoF0rkuPZ3W1VgVbNVvwYIQb1QkhEaKW5uf/mxCM56vdKIMj/u
	 hrxH0X/7GRoDqDk8rRLkdA3vO0QCOaO6ogEOFyX7vyDPq1kQeluns5FYPwoGVO/zy5kqT
	 6Y4jl2iY6eXgXD2dkGJ2OrU3+vDDa5+1VdnwNPF+3meskc9JKuE8UuflwcJCQ25bjGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795764244;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=iuoPT7GWHCy8y3Pnq7fa2Pgny3M41VIvCq3XqYr43v4=;
	b=wMf6HkQ0magigVkjKOgGWfBDR3707OF1GlaNAxFRPcjP2MAhZpN+koc0kUZJ/z4iNmeE
	 565oJ7/Bl5OgdCNyshqregIKFQ7OSaJwXZAFEmC7v2rYNHmkRpKsyRSgDCPT7a39nrzL8
	 4Bcn/PjsZdCi85V1KRps9W/EcOJtsxjDHZ1DMY0l4iGUrbbs8NqxaukMTWNngb49TXrQ9
	 5Kv3TKOkL+CwhFVIIfg1VXuULE30yk8OI9nbksc4ya7CueMVdHD9q8T+hhEuI6XCUYfDR
	 8A2s9VGDjG+z6nGYjeyuUwTewftLAxgIlWIOdi9LSNp/iU0lcBv0eiR/9iMgDdQ/W7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="A//963ox";
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB650606A31C
	for <mptcp@lists.linux.dev>; Fri, 27 Nov 2026 07:24:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB650606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=A//963ox
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5365d725440so69468081cf.0
        for <mptcp@lists.linux.dev>; Thu, 26 Nov 2026 23:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795764243; x=1796369043; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iuoPT7GWHCy8y3Pnq7fa2Pgny3M41VIvCq3XqYr43v4=;
        b=A//963oxqYeQSgM6WPZyeY/WDq1hoBtjOeXIV1h1z5qXi2JLYG46X6BwbAe2eQ+WKm
         H/2GTLdliBOFMcbv9RW0i2xMINcGcS7dm3VlAZZHoF/+vJByxTRfZCadCEJzR5Vmauga
         PLIqjUAonw6ntTveUuQWviNa1/Rhx2c2U9ClK9iAeed30BAoH3WNipKM9iQDloXIuQ8y
         okrjmnQdYkA2hA8nm18Eto6mY0MyRjwRAUHv9HtCj0aeIYaMQHPUpn7Gc0dwuH8WsQ08
         FM0xHmu4+BBuRWsdIWKlE2xVLMf5Sge5iGP7hZUvhhs/43R7LOp+vLNJFa4wnIdwgVoQ
         i0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795764243; x=1796369043;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuoPT7GWHCy8y3Pnq7fa2Pgny3M41VIvCq3XqYr43v4=;
        b=arH5amS2kdmgGMIrm+v64e6KUPMvsug6zxuCqlwOGTcrSNdNs/MT7BBPw8YLJnHZ33
         va98e8BP6Cj2WWHbBULlkQYJ9A1GTjTFxY+OyLmkeON1oWhhWvr7wj2T/hx59ZzsfkaT
         rvrejyNX9+zUYU1x205Vm6NMpKPo7+1hOdgDyqI7aQPu8sMM+8liIvUAhB3A+qqz1A2G
         fXgXpdFmNZDe2eRhx8YZvlfa4rKdEx5FDAXVOah8fzExWSvf7VgO81f+EyeTfJis7jzE
         /13cdsz/7kELSJ4ma5TS1ZBZMzFrkANi3DIdWQ1pZicyPVih4OTAU4vs1eS5Awu4MPmz
         CXQQ==
X-Gm-Message-State: APuU4Z/A4C1dZvqbl0AmcGneUjymXk9BZVd7JE4jgJwpIJTeKotxGDIo
	5Q4GlyxU20WF3iBv+FkE/f35fEEorT8XouzqIsz7otdQ02TjoLTs4x3C4fM8
X-Gm-Gg: AZFdTZdwmKyfd2Mo9QuF4Ybu7JX8mP2Av9K2ZiFvD+keTdf+pvPM4TDscUVNHbPxWuL
	PSPtoenGocUcCbpSOIp5Zy4+lVLXRLgjME1rYXoR0GJDzHHqaGDveul31wOTK2NXsOdJzhlFhNN
	/y7v+YfBiRpSNJISN1eOZFtUkKx3NlR8usEhlxHE4hLdR4P3L+7MqUpz6ucOAVvUBBxzfL9uH3w
	p7IC6xh2qczW1rPw8DNjca4kfBmT+au+q6wWKT28Pd/Gepm5kWwtvirMzvaHXGVyiL8UUjTwfUY
	mKkVMoqserK4G0whFgL/SdNei7mnt7m9wtolQQlqMBiwU67K7GyI8x+Z5UzNwXOwwuQ/kINcjZx
	mP+f0WkU2lQbIstj0oPq4EF/RFOOxA62J2u8ddW9QtG7tjHrEoeI2mxdy16Ko597QjDCtHFq/Et
	Olh+Ze445GVn46pMG8IlXqI27UE1ovlxD40AeFYjXwkLoGqyD+lpCaxs/tikXtfGPFoYEExYUYM
	8aIKktOFocDo/E9GXfHdGplV2y4qTjuclyXXdoeF01TSLjAsydQMdbmJdXUkKpb9DQXJdhFu/bX
	sw1Ap1TgJpiaxL5ZhyztxrmYHgmiTbZPibpB7dCQSBOsvAZwVjLqo5eULjgroSJmxZgjgJEL9ac
	vvlPa9jen
X-Received: by 2002:ac8:5f0b:0:b0:54b:5cc6:6036 with SMTP id d75a77b69052e-55d76afed61mr462747101cf.58.1795764242881;
        Thu, 26 Nov 2026 23:24:02 -0800 (PST)
Received: from github.com (ec2-3-41-210-135.compute-1.amazonaws.com. [3.41.210.135])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-9213514d20esm209732356d6.23.2026.11.26.23.24.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 23:24:02 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795753727.git.tanggeliang@kylinos.cn>
References: <cover.1795753727.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 0/7] mptcp: add MSG_ZEROCOPY support
Message-ID: <3fe63f2d-ef55-cd35-9e27-6facaee62a3b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 07:24:01 +0000
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

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): packetdrill_regressions =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_diag =E2=9A=A0=EF=B8=8F=20
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 4 failed test(s): =
regression:sched-clientlim regression:sched-mem-pressure =
regression:sched-rmem(4) validation:sched-loss =E2=9A=A0=EF=B8=8F  (43 new =
outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next=
/actions/runs/45945376877

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/9f256aa238=
6e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1223936


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
