Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF2191F65
	for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729587845; cv=none; b=OYEiOWvq682Ux32WiTTw7KAJ3iQvGKppPNokQQNWFAnoY8Z6f5RgTV8/cHZ8UTPh53r+cxFSj2cIN/cNroNwiYcYduzvUaBflNK84rbQXHda03kC8C767Csa02eEjl+NOUBpksd0qCjN2s/G4G2F1CvDTgEQv60TdiRVc3x3EHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729587845; c=relaxed/simple;
	bh=iAKfEaKVJ8+pk3E7QMS2QILm3HrQuOMhszS6wETSX/g=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=YFqIjjuShH4mnEZrhsTrHe9clHKppi9pshdwI+/mL9C83cgoxSAUpKy/ruafSU6AH1+Oq+mKa/PzvUkf1Z2JRRlF8OKPwHLotcUlpN6NmROOxrlE8gwRUOewgdedeyI3QUIwkUUdjOgCFtZzEp/f4G2UDQRx7jN9gWEYVc8hfgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N51MMSaR; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N51MMSaR"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-84fc818f518so1486283241.2
        for <mptcp@lists.linux.dev>; Tue, 22 Oct 2024 02:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729587843; x=1730192643; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t+PvoRsjir2UNWz5Ukoh8ZZovMIBeSYLT43PENp79i0=;
        b=N51MMSaRY9H/LOMBClIhpzhfy9ni6fDtm9oxZSKQPfF1fSLVqyUpUkEi+VOgKExA+4
         LalK2wuaQOBrha4fPF/fw8OOoMDe95pMbnvr7BB7f0l/qQixp8E6p7rQX5gUJwI971ek
         l5Gnsnax6vu73KLojcyh6FOuXfCG67bz7HIcIfNUpR7aiXizskb74UMYKLwSaJxhuIJh
         vSI0CyDBYKow5mOAh/l9q2YsVyAzPMjwy4DBKhEvT+zbVeh5EF/5L1+5Chld8ptF3WlR
         tiTG46vWiZIjDIM66VakLWDEzb5Z8Pvy1dS68ZKqq7MVtN9+oNkfBL2E4WYgoao/Pq3i
         650Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729587843; x=1730192643;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t+PvoRsjir2UNWz5Ukoh8ZZovMIBeSYLT43PENp79i0=;
        b=KQLETtedXxXBsfmTclESPoIt+9BkaztDZyxCYGTnvmr+AznOIpQ0YG/LE2l+K8/+ZW
         WOpjdxCmd3AqRt0g0YjELfy0mFo0bA5dMjyqztK3W2KQccTR9q9ckiRjjle6wjcwUIU/
         cnmzEOUvcKm+5rCrPJ8OEOf/gVbFCnTohglvpZoq2jh/0SYAxT1CvS2DcM+vLEsAYXy0
         +Hgp5+AgeYV8uFkdCP1K8lEQviS6+48cpqBzhwAjKlqUocuOddJiKEEF/PcUfYk4Mfm5
         eeYxG0PrB/TnY5qMMU4Xi7zot1t9Bhg6d2NGmXdaDwERYPM9Q8cm232d1snM5Fc7jxKv
         xVZQ==
X-Gm-Message-State: AOJu0YyOhWoKVD9yaoO62AootWev2PUZvxVHVfM1WskpHq4/IArCLnor
	nosd2hpraNwYMeOXn1OYBT1tQ/lJ7I6YVCZo4vHfllam15PeROQ4GYqk
X-Google-Smtp-Source: AGHT+IG3AHyyWb11sQOz/LV+qU9QQCw54B3OUo2qIon5eAs72BYTXu9lDIXTVVzdORgBGrGjaV37LA==
X-Received: by 2002:a05:6102:358f:b0:498:ef8d:8368 with SMTP id ada2fe7eead31-4a5d6b15e08mr13595798137.13.1729587842768;
        Tue, 22 Oct 2024 02:04:02 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.131.78])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a883f1sm257963685a.130.2024.10.22.02.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 02:04:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1729583414.git.tanggeliang@kylinos.cn>
References: <cover.1729583414.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v7 0/5] use bpf_iter in bpf schedulers
Message-ID: <4836dcfe-d8cb-7c90-e663-95555f4c8f96@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Oct 2024 09:04:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/11455976017

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/6d7d2f41f644
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D901714


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
