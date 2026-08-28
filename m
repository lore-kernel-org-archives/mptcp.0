Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835632D8385
	for <mptcp@lists.linux.dev>; Fri, 28 Aug 2026 05:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787893324; cv=none; b=GKWo2kb/yQZYFlcKEdlOdlHUW9P9JWv0INC2JwJ53sy1u7vYGkPbNG35imaBXkXwHHdvseT3H1K7wBe4RwBuxyD9w4laewKQL4CmVmK5a4+Cd6HNP+2hMSA1j1WrDffAeL3EwyjRMOnZbKqOxux9VPBNY+bA42EiqtfQct8FRmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787893324; c=relaxed/simple;
	bh=R30fZFfGtuKTNKPJtmTj3KQ4wYi1YllIMXvBf47XcBQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=PcxvGP3/wja7AxS90e8+vtDjsZgHp/kayx24pcEnuk/apFDEVPYqFi0FvjfjNgWV1kKgCqjHXTQ4piRjvZ0zOV1ooItTdGXnSxy2bw7cuw1T0HkTrVUoESVEeEVWx1igPllISKGNpzAPkvjKVC1Dgk3+EWY2wD/kbXnc7A6GWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rZ8BGdS4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rZ8BGdS4"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-851cbd64814so65776b3a.1
        for <mptcp@lists.linux.dev>; Thu, 27 Aug 2026 22:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787893323; x=1788498123; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+iKLYtGr5pOf7nfSLgPRIqBOX/3BJxzAi/X2xFUB0QQ=;
        b=rZ8BGdS4wHB0/KlUT+fOAdfMb4gDbpohlyFPkTFJKP441p55Rwu/pT+WSmK5w2HIRy
         fkYd+x7EUDE5vfMjSOY/iUBwRKcca/GWQ7+Tt/qE/5j33zujIO1avX2sumNa0UDuZAWS
         tCgjhCHeY/OB9YNtmNhOySN+NlY3E4kKmmjSjB5KKJtvZ8vbwK8vvvEl/Ns2pgyWf+Vx
         22rXXo668AlMXWPQdOjQEz03KQnCGERTxu21pVXp6NRM7EFJvHeHcW7BKIl6C3ZG4QRX
         ffngBrfdDJvGef5ZG3b1UWctyNrcA8gNN03meIqzYcUgSr/8KT8ZFXmQJOXF6TAvgPXt
         3Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787893323; x=1788498123;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+iKLYtGr5pOf7nfSLgPRIqBOX/3BJxzAi/X2xFUB0QQ=;
        b=aNnodm6ykZar17qy+mwLKlnerya9AlRkQgbCcZMmK4ltTr/ASLB4F8p42eorZKJVM6
         NsyYhrDzMULIprVgn7OEbdGayQ6JUVXGeejNTXO5fVhR7hsY5Tt6wC3zmNeH6bhbr2OH
         1IFYzVm3GL+v7U6sckwZ5VKKrd257fV50VPg6vEYs86nDyucPEsYZzSiRCd1i6HZ9MbZ
         aM5h3e7ttOkm6fVTKNkQvi1NovB1/tzE069RA9zfPAiTXu/91SxBFp8hoMEzoS3oI5B1
         Jb481Cu/yW6fqfmIAafWeQlZ4hvDJPj2IVxxphhqfnNj/U5NmF054SrlzmyCoZCD40tQ
         EMUQ==
X-Gm-Message-State: AFuF++lqiEDPJL9gPA2DK4m7Dx6KFV24jG8eAWrlDhNRwxOTaDvsXfhM
	YUB6PfTeYnEwm79AP7AX/2DVnNuiZldW0Sseg6V/qjYNUbXSCrJUQ3Rivi02wyY=
X-Gm-Gg: AR+sD12XkwBrxrVRHWfOr8kU9bbgJqfkJbjMnQSlXOdZYnzmAzFB11QRB2ODwO9lRer
	jJkgGudm8iZCKmPVqaLvw5VSq9S3LLGuJtmSpsRgvL3JgRbq4QpU0NChqzopJBCbbkxrgZHBqaK
	KFAJ0y4Dey9/H82fG1DScxbEqhg3b2IvMrVtSBkw6pyj1IANbm6GLHpLMTVLYLLlfk2DnVJxO8o
	esXlY1NF+YkJOPr2lzPBybQa1nBmgEa93IZgMwwT11WUWg0S6irmNmIQ+5s5nldw+aD44HtnPyp
	TaOTgzr7k3FNRMtBDrw2HplcWCxjQPJn8k4No4IhPypelfz9KO0rxxMWR6GeRMGcCGf+j4G0+BO
	QHd/V0/aXf+zY/B49lAaIgj4hyghUsp1nVYMZWKR3ltWSZ2vlq0G3xWjWR+2Gwn++Q8mGj6n9Ux
	wJ34O8XtA3o/7dj5hHZKYgBEYRs3/WoT2r/ZRV7JHZD/irdQZWG9EFvgyHETbQfv/5f4VL2QUU0
	A==
X-Received: by 2002:a05:6a00:17a3:b0:842:5b66:3c7f with SMTP id d2e1a72fcca58-85625842e10mr8436527b3a.0.1787893322774;
        Thu, 27 Aug 2026 22:02:02 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.236.227])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-856a2ea6faesm197759b3a.31.2026.08.27.22.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 22:02:01 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1787888115.git.tanggeliang@kylinos.cn>
References: <cover.1787888115.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v10 0/9] Reduce the differences between TCP
 and MPTCP for TLS usage
Message-ID: <6c8f83ea-a3a7-0410-0311-51933acb9b7f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 05:02:00 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Unstable: 2 failed =
test(s): packetdrill_add_addr selftest_simult_flows =E2=9A=A0=EF=B8=8F=20
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/runs/331411=
05527

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/d876351d240e
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1152948


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
