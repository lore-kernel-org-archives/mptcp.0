Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFFD278156
	for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 12:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771591349; cv=none; b=ev+cV8gAGPnPygCObon+5J759YowQgGxl1r0hYwf/1oKj8y8v8YZLOopr5cVHrPhYugvv06bloWObh8tiza+0w36duDdST9+zobnIjuxcPhQ/+w3DsaqZvC+7W0v4UxctfTY8QC3w+pG93xcZwDuPMVBLJqLpPKp6Nla6j+dalU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771591349; c=relaxed/simple;
	bh=hXwLWfUTdT+S/c6Q5uOuXl1PwXkN2ERUh/cUz3ld6Iw=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ehoHPE98WN5z8E7DVLePOvwxH7zxpE7odjOfCPgcqHmdkyrtKUM3Vwq4z/wfMfmHeBWy4RPfETjz1r0axn8eWmxRqGPjGwKYg2Q2X+7ryHt/akfZknhSLz5VYcHwwMJZlMDvBknTrugkb5AjBP0EPq9BeMxbXnta2/8b/sznIzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQf5DelF; arc=none smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQf5DelF"
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-896fa834290so22886866d6.1
        for <mptcp@lists.linux.dev>; Fri, 20 Feb 2026 04:42:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771591347; x=1772196147; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsLmC2zeHZe6tlvSkp86ccMdYqIIv+YOnG+TQO92jjM=;
        b=OQf5DelFljN7iDzeHYkGIT+wtP1SL9PpLgoqMY/+B13tdNCkoFAiVH8Y7PPeWq0QiJ
         NkVF5okX3U0/OIGe3jdc1s7YBO80YPo2S6b8QROWwULxJ6y/f7TL5kOOipE0g4zuPN0R
         DDrUy/pb7Pgp89JeByp/NY+2Tki7BrJZWNHiKrPHHh6elR49E52jc3RbNRNEBWgfQFH3
         NrLDMJr8Bd3sonFjughs0gPNTGVFFunKSZ+q3f/sCvprgA1Mcr1GrUre3dVteMEM3TRJ
         kFnRxMPFqeO3NFnjQjCFCWKCpsg5A/5yV5DN5Jz8ZXwpr4Ht56tz5fDp0+FsEnM704Ll
         atwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771591347; x=1772196147;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rsLmC2zeHZe6tlvSkp86ccMdYqIIv+YOnG+TQO92jjM=;
        b=NSmz39gYS9QW+lVQTb1nd7SZ2XSwYe/aByxO54ou+KF7m5fA8GjZu3sar7KAse4Lk9
         Fq8s6dBLCY3Vr16o16qz22RT3tp3t1D4E1y7Ejlu5v3tS98W2W7XMfpbNGK/4xozURIX
         vxaV9EOnYxSzGjCAhtBPIxo8sMi3MPoop/3foqI1GUDVJpGMsaBerqCpFvLasqAxuF1N
         Ft/jcmguCiwWayjTJJ6eh0xotgTQW2F59a/heofdiRxoRWKpcRYn3/A6Gm8kXUfHWnPD
         7TFA48Ky/fjzsMjE8h+arzVNPMCAU3teojz8vR/LLqrH5h6C1bq3L+0f7uCNNWHdJgsc
         q40Q==
X-Gm-Message-State: AOJu0YwW9o1V7ckACmeckMTWl08wmfoEnWzuDcGaiHZ8wejr5gh62AMV
	RfrvkQYmZ0q+ueZn6QHPAYBCD7dAqCE0Nwzovx0MWSmfio/csKvEzKo=
X-Gm-Gg: AZuq6aLbmeYW2fl5v7RBttdLeETQl0KmXryvlzU0z2J9rG13pOOb27et8fSWlW2uQQG
	9B2LaPdI4OsWdqquQqkra4YAZ85+17zjszxlfzarXccMXogigNlTS5dqlxlYJ3yhqBNNens/jt7
	S90/TdnXtkTEng2O5GDSQ6eRxV4NHQtOHRT+ijH5DqU3WjXrTRUb8psS7ZHZNQUVP6w5mQX1Hv3
	4ol7vJGrTiwVYEXFqd/DnFLdPdiX7prKF29kuXwQlXS4lCXV2/2itayrj9ria6A3ktwU9h8BXOT
	iQR/Os0E5u3eyKUUardE9Ljp6aQJsreMljmFDts3XpXTimk3RrJpqZZiNrq+mARAhMJqENMA5fi
	q2eRozqVi+HumsZ2HqzTzYr5KbFw3VQIBH0JuBr1M3PNOcINU32z++XWaeEalTIlg+vNaxfSX6e
	HYi+4UZnIuI5UJSc5FHWfhDocSKqdQYZsao+c9tA==
X-Received: by 2002:a05:6214:1946:b0:892:66bb:fdbb with SMTP id 6a1803df08f44-89971aff227mr14922216d6.23.1771591346978;
        Fri, 20 Feb 2026 04:42:26 -0800 (PST)
Received: from [127.0.0.1] ([172.183.131.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc7f82csm241632786d6.4.2026.02.20.04.42.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 04:42:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
References: <20260220-mptcp-issue-612-v2-0-089684a6edcb@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/2] mptcp: pm: avoid sending RM_ADDR over
 the same subflow
Message-ID: <9cf98f3c-dc39-2a18-56d2-cd701b12e177@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 20 Feb 2026 12:42:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Notice: Call Traces at =
boot time, rebooted and continued =F0=9F=94=B4
- KVM Validation: btf-normal=
 (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Notice: Call Traces at boot time, rebooted and continued =
=F0=9F=94=B4
- Task: https://github.com/multipath-tcp/mptcp_net-next/action=
s/runs/22222681925

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6208f5fa9a3d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1055875


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
