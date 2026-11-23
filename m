Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795430535;
	b=lSX4gttfqeXRjUSQbQqzHu3ur7UFs4dmWzNMxSFvCBku2Z8p+fz7rfifkZ1ZM9U6sZI8
	 wzdQYDlbgFY8f4xtV0ANg94qc5S+VtNYgi8z9todTe3ABFIUTa+37yUOIh1neBMp82pIM
	 cVSrWaQzIEoifyNByUqA7sBdtrArQ/GeBCs94gWnL/k7Djmzgl9KrjaTQryWeIO3X1AcW
	 GAeDeTRBJ+CGONhbSRkdlYMVtgqF09XeaqNFNoDd/Xo0UG61rqaCIQZ9JMvmqE+tKkiob
	 cBqLlhD3aymK7Ugta64j91Gy1yCSVXHP2G6s8NeRVnbkADnOymi6pxblKN5E5UmQxvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795430535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Reply-To:
	 In-Reply-To:References:Subject:Message-ID:Content-Transfer-Encoding:
	 Date:MIME-Version:Content-Type;
	bh=yqtJ+PAs5hsnw22IBMFNmF3kKfFnqVncwrRshCyHYUc=;
	b=uprgjEZprhWCdaLx6R+xtOSuZhHsuGhaIX6OHuDCOpNXMZHt5s7FO/bKlIkvVeJiclWs
	 fbg0iTP4Yfi1pZouK75IZoXq83g7Hvg2Sl4UXlsepkiv2bBwrLnpzaVZoK99qoVXw+BhI
	 mw9Kn5bDHCR7RsIupXW5Sv5mG3yDNqLufYls4o61gb9sjCbjb70oTA2TDSqgDaPF6cidJ
	 K6130qwe4ns4i04ODxmHESDCXsEdONdr6yXwsoUtGWZrXN4a1JtcQMqtuRxKxBgLRv4Xp
	 ZrzMm5NCtrrCjY7w9Bh34mfw8TwfPRbfZQSVC4JQyA80mjM+u4A4eKoZpHpP7DewRdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJHH33nV;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E461606A31A
	for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 10:42:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E461606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJHH33nV
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-38699cf08dfso2824036eec.1
        for <mptcp@lists.linux.dev>; Mon, 23 Nov 2026 02:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795430534; x=1796035334; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yqtJ+PAs5hsnw22IBMFNmF3kKfFnqVncwrRshCyHYUc=;
        b=jJHH33nVCsREqzAJaWkPucNPuR5SXClU8p4d+jWEmUGIjFLYr9oaxitKSKyEjymmqf
         RxpzS1HtNdcQ29kEYUZqU3v5iJ+ElQdabIPnLfLrv4MRCSgZ/JXVlUbwCL+8NNicwNeu
         aV4t4jV/pItOns7FWTFHZkVjsS9KYzpCPbdBZFVMcNkdRAhN3KKN6LtXVmQb4WYMu5x7
         JUzaqUviXTg8WcHrJXnzmhdJF7ZDxVD6RvSnKQchQy3gr4CszAHye2PCz8+OSaLgyxs8
         9eQUgxG/aohqcdVo8tmcRoTG655UYUPNkgYROqwtvZOH8AbuPLKC4ZqHQ+V4Hw1S8kL0
         9BHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795430534; x=1796035334;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yqtJ+PAs5hsnw22IBMFNmF3kKfFnqVncwrRshCyHYUc=;
        b=PsR9cErDbddY73QpxF8KmExoR8Ted1PLbigiXcIV3LwpUItNvn2LluBjdySj4fzcGW
         eLPaZkH4EgfQfyy8wijR3JJFOprhJKiQ+TaX599y39H9eOAMBF3znPTM2PPoL3LMNjVJ
         yBJX+ChnW16alhZ0ZWrV5DLwfrKWm28uqJkSGAyobygauV2kbHl6EFcCnbxW42hTAeEE
         AZa+HOP+0B3S4XKU02tiuuAK+zSmlC4b8Msh2OjVTjw62cVwqxvuVVKYQ0q7GwbcZ7iS
         ebI3rH3b4bsI27PMxpsqOZcnjx+edmaf2tP254sbeYfTgL29nHTYvw3/xoZW8kgjVco+
         YEYA==
X-Gm-Message-State: APuU4Z93CozE9P1zyoOhOXFjcd0bH31M83Nyj8UkKs3RUMp4aQEmNDtf
	lqAX7xoBOZfjxGHwn6jrhtnrO2/kAw7t3wviVFUhmA4p1KzZYuBN/iTDNyLh
X-Gm-Gg: AZFdTZfOw80at2ehKUYaseCFuBZeRcj1i0c4tyFhZEfiAktRhjzUB9mKZ66UGgmVyZG
	DSeX2KvlGwyMCrbF+C293/lLFQrLOn3d1tSDJB2vYDwBGuWWrBWpOP2kdDzs4PugufvquPVTNuR
	Bwgj7VcotfyVML/fOJhM//UQYCU3/6dcjOd5BMetm9TW3KrwBnDWd83k/0M9CvHyiqhoj++4u99
	jr6kYuZuTIPff2mnra2XYFtZu0kek44d57x1XTqxSIthY1Zp/juOAsZgBe6OYv3tUQ9siChungy
	p2WZesaHtvJCq3q5Ee/6gBYxLa1ikFYTZoBk9jbwVC3yC8cXAcXmZQGb7/457X6whBT4tdoM4MN
	wx3N334QLsXcrrsRvySGhs50+J800FSkD1IznBYiey6frBWeXEcavcQW0dW4zLT231rOj+EAML9
	pul+ScwNG0mK5ejpkcVvq7tEzMWBgZbH8EDSTLIy1kXNIHz8VH0tC3iuozr6jUaUz208GRiPA5R
	Ad1YuUuzZoJstPpz9Zf+9ktELyXiLC4dnDw0RH6J9QjRRirp6vcfXokBY6BiAwUfZfocJcsUEWL
	s8tUA1hJ2aq4DDh2q0RdwBqDa30Dy/VqGjYuLiwi
X-Received: by 2002:a05:7301:259a:b0:36e:800a:71fe with SMTP id 5a478bee46e88-3856c4b844cmr11145984eec.1.1795430534117;
        Mon, 23 Nov 2026 02:42:14 -0800 (PST)
Received: from github.com ([57.154.13.124])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3866f299d0bsm27845272eec.19.2026.11.23.02.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 02:42:13 -0800 (PST)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1795421388.git.tanggeliang@kylinos.cn>
References: <cover.1795421388.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v8 0/7] mptcp: add MSG_ZEROCOPY support
Message-ID: <53676a79-7a84-3a62-a791-8c5cc77ffd54@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 10:42:13 +0000
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
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Unstable: 4 failed test(s): regression:sched-mem-pressure =
regression:sched-rmem regression:sched-serverlim validation:sched-loss(2) =
=E2=9A=A0=EF=B8=8F  (2 improvements, 105 new outliers to review)
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/451406=
57205

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ef940c87598b
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1219302


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
