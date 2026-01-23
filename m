Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FF3231829
	for <mptcp@lists.linux.dev>; Fri, 23 Jan 2026 11:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769166196; cv=none; b=BowB+GfSz7Z90m970l8RNsYn5WXrHf5tQUBakv/2gv9ZOpwas0mUST8pggAwsd6RCSrjIs7WByVVKOuaboLvrbbdj6sLh1/c9NV7xosDWsyyYcknISY4L/uB/mbetFsKaW+0z1sslJ0xaFOgeVTTWVclnhVC1bdgDHprKgmEUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769166196; c=relaxed/simple;
	bh=YaJLT+7UqONOwV76+2hCQfjWuMRzRfjhakrQ9mu/nVk=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=hCFnIk3G6ewH5GjqHV+jMoi70qtuMDIPROi2dRj0IPO5HH6H9OO2M6fMCL+sjkdkZKR1iatF9hmkKNuIQO9BtKj/BYPfi3MQrvy5jIBqKQI95ov2XvXUcnqAXz3AFxxrbXORcSYwLNKS3gNSx4jH7d4JupCRMIZjSdOOe8vp2Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JxiMZwlt; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JxiMZwlt"
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b6b0500e06so2603467eec.1
        for <mptcp@lists.linux.dev>; Fri, 23 Jan 2026 03:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769166194; x=1769770994; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LbAGb5Fj484jr35jHhySHbrVep12MfwFCiod2TPstS0=;
        b=JxiMZwltUIFn2vp7NPXAd0bV7iRIqPO0puBKyNgqjHMdQz21bcGHrpPDyvCQTH6JHF
         1Voxvgy19vBGClut5BEDWA3qTo08P6gKW+XfXwkHNTk6HB78EPjrK9ov7wh/0VCIvPzo
         Ug7fOR1xNkMtAlTCbJLBMPV2p48y43v9axdTCdePrJzmDqyRREzRfE+SVSauHRN8qCjI
         M796PYJNmTMY9kCVfT+R7nOU7GQEP1JCI0fpfeB1hW8Qya3aO0slQGECU7t70OuN9Zdl
         QStPcc88meyVuYnq6X4Fa53Bvkagk76NKF6DNXJKJhQ1FeYlfdIheMQkrZFkTVNeAzAr
         SBzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769166194; x=1769770994;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LbAGb5Fj484jr35jHhySHbrVep12MfwFCiod2TPstS0=;
        b=ZDWXnWYC7N6AFumWbns/sWMrECDVMETEhFLpTTK4V0TuKAn/CLNxZyvnpnASKPsH6u
         XUcZn4MxB6sylPQScm7olObWM3gzse/ine6dm3FSQPZTGl2R21EFQwIv9xTyuQPgdufN
         wEGZu+ekiI8nhTT27LT8NRTQv7+4q2XJwq5fPV/kwBSBvod0rLXDR730SaNAvXAfN4IH
         J1mKOt7kM+Z+HVV2hBpbHFEXuHIJD5JFzvdf9mHxK0EHTZy7B5er+PeGXi6hY7JgfAqC
         mTxfFx3noreLsvyDSTQsCUtA5Z8jro4ytaIOeLxwBjeFqWIBPmoyphOMA0wQvEo6Zjf8
         Y19g==
X-Gm-Message-State: AOJu0Yx2ENLnbFfTWfFMtWBbhzL/bxU6+EJthb+FyJOP6o6PrgEA83FA
	zktybMegHgbd4aQt5OD4gUqRmnwF5+JzUm3tQKIQZLtLxlCFVhonGaU=
X-Gm-Gg: AZuq6aJBxapBVrEk/BsNHFwPtOOMV/4yfwUmu7GbmxcTjfwiyT+nmNixTcClhpK7evZ
	2meZTfQyY7RQDLH0dVDRRDumZv4JcasqZWVTa8ejqa9mTNoibKvAQ8+lrTgQbbHjIsAEmnyfrRm
	BwdTPqcwI8Z89JB7xBpxIAWWly2K5YFz1YQW6QH2ELjXwnRlyc6rFA5TzD6jiqpLfHVpgspSxEI
	WGSbd0TBfV11bcfqf4CXryTaGVZJWhEJ/2Jca9MMBt273Nhb/zvYVWk5eipCrc2Mz+Uy9VjI7Ux
	DL0m2QFSzPc8db7UjeHE3mnEdKOEXR7H1TwILWSKdYyoPLYI5uGmFsFwsw7rdC4qzfoEHpAHbax
	Axl9UOMgRtQvd2Ps+fzx1cHkVP/oqZrPlAgfXevTFQ5Q0XNev/T5axgjIvvfv/nw+lfEMTiAspg
	i4FJBkZAQUSwDqT1iKilOa1ZM=
X-Received: by 2002:a05:693c:310d:b0:2b7:1ef:5862 with SMTP id 5a478bee46e88-2b739957076mr1105053eec.4.1769166194189;
        Fri, 23 Jan 2026 03:03:14 -0800 (PST)
Received: from [127.0.0.1] ([20.168.119.23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b73aa03ecasm2465484eec.27.2026.01.23.03.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jan 2026 03:03:13 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260123030327.3041148-1-edumazet@google.com>
References: <20260123030327.3041148-1-edumazet@google.com>
Subject: Re: [PATCH v2 net] mptcp: fix race in
 mptcp_pm_nl_flush_addrs_doit()
Message-ID: <f146d0f7-1d16-e749-04a9-05a79d1ddf98@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Jan 2026 11:03:13 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Eric,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 1 failed =
test(s): selftest_simult_flows =F0=9F=94=B4
- KVM Validation: normal (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only =
selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only=
 bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/21281916251

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/c14ce3016a03
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1045988


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
