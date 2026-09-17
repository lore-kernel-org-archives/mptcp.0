Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334D33876A0
	for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 09:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789638714; cv=none; b=NEKB0q/XzgnCpHMgWwJu9gpC7ZsqlaRGcaAc2IKkBLmpELC7YMo7jeA5k0hvpt2Yj+Y9ytlZe2ljHvIm7f30RNH1TdEitwEV18vO5VDv74dC6sxq6ARiswmg/dZ7EMyJ3vHmUDv2A5XbeoqNn5ojRZLiEBj5EtsVnGbq2dx2Bo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789638714; c=relaxed/simple;
	bh=NW97ugCCH4gBahWk9UxiS2oUD6Fope5BTnsXyKzyl5w=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=WP3SloVztYnt2c9qxE/LxlKDdWsoPk1i1QU0kJ5OOvvu2DDSN5lFevgJJokmnn8PittfdhLAXlCQWmBJXP9IjysE4mk/BlzkFgrs6dVdi5PzF86qziX9QPvA+J2bEao0GjvL0Sv5SQKlSOAvxOv+jRqiwmyWGsV6i6diTBeDXB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYRx7YHj; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYRx7YHj"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7f4df360cc9so529357a34.1
        for <mptcp@lists.linux.dev>; Thu, 17 Sep 2026 02:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789638699; x=1790243499; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0wWZDROQXwp/xJ+ehvU0s/XkJrh1mZl+USBlQAW8XFg=;
        b=cYRx7YHjb/6uIIxPaqUlnL+84Yii5js9Q8bkzyArJY4jv/fb2WPZxugGMwb0A7Sfut
         inj+rXhrr34i7i1KxCGQfnSDY198+xmuKZz8auQAAMfK5POdd6sCkmDsBNpBzmIaxsa7
         LDeQ5/i6QX1htuluXh4C60X6CWK8t/yNCoLg35I4D5BwTQPX5JxzTDSO2VEyZ9QXAeHJ
         2esfVzKLfPoZkEmG4IdJyu8oodGNK1a5qIQOU0EHJT2Ea8TdMmiYyFH54VpIVQhce2wJ
         YugxrUFRbLhi21L2Dt04za1hI413xVIWKDSzycbERte8KX+czhwugTH5PCl3g3uXqZlI
         tw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789638699; x=1790243499;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0wWZDROQXwp/xJ+ehvU0s/XkJrh1mZl+USBlQAW8XFg=;
        b=X/eH56eC/J1gGbIWzvF+5xiYGWV5OXBWgFq4yjKyYVgf5pzZLT7whkkGkhpJ+FWXU0
         VnPPaFpnlD8kVYWGcVKrkuNy1VpGWG2w+l18XqrfBH+VvdA1NDZdDLiolKwDGzWb5xPm
         Ant8D//GyN336MOfPov2ZqmK186g2thgjcLeqqDf9icaIvvtBkLvUgdPkatb9Q0PfXMF
         7yVOgkhqACZBEjd/YzdCWh6GsdX5TwFWfEAe7C7Sug/BF2CKpHGcmZv3nSm9WFTY6mqw
         15sJYeSXSa7uNG9rUkLS6N7zs6g88MUXvt5NLVkarm8qeAOdK+wJ7kkcTnH1COdKV7xu
         GFkQ==
X-Gm-Message-State: AFuF++keNEzBkbYUgyPnGmcCBpmFwSR3VHduulqlRx0UaDFpSOx48SLE
	5Z1fG/utvsNY4iu6FaFm3bpXC92VLK481LcrEF8DSzX44TyPJAKc7vJ/rpRV2j0=
X-Gm-Gg: AYBFou1XyOOWSdK7GdlTsT388+7O7F0yosOTv9EHIF+5fIipFo5H/ueaPjsdpptbKoM
	OQQl48y0JBAv+NNNIYNKdpUzuQxxnrdbhiINHHVnm5TgF6sKbIBueWuqWIWDh+QKHl511i4dxjx
	+/fnzOM79+bMhrFJvBRFagNNTFuoPKn7tg/EfFV4QZLznnWwG4fe7NNkfKpup5jwQelhjTzEAnF
	KhTQbsGufs7SiZ7vwuUgPFKb/ctMB4GC9fXDSNJ0R14WPvtRPnFnNYb1iH0bV3wOEbTc23luK4T
	Q/Ey2TQaUwBt8iE8WzzZjx5TMIYDlHjXJp8az7MPk0e14+W/rdLrZ4r+t2AoyV+frKQ5NnA87lr
	W4e7vY6nXyB2QB+Snwm405of7Vo3dUmf2Cb7YAU9yGf9JYWmLZzSg4jatnXzlriaV3YHYDqyIKq
	cSOi4pvq/aN723Pg/qJPGLAnRtbDXYSitEh/hhvXtEl+kGAVl98Xbcw8PXQhLUtJpQb9BOBPJKw
	qLra1ocs8vw
X-Received: by 2002:a9d:7f12:0:b0:807:3423:e50b with SMTP id 46e09a7af769-80c4c50c88dmr1815490a34.12.1789638698699;
        Thu, 17 Sep 2026 02:51:38 -0700 (PDT)
Received: from [127.0.0.1] ([135.119.79.33])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-80c46dbe483sm2045710a34.20.2026.09.17.02.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 02:51:37 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <5bc803abb4e27054eaffc8b26db7812e6347b0dd.1789634247.git.tanggeliang@kylinos.cn>
References:
 <5bc803abb4e27054eaffc8b26db7812e6347b0dd.1789634247.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH net-next v3] tls: drop duplicate check_app_limited in
 tls_push_sg
Message-ID: <0c8eabf8-c464-a380-e6a3-8a34ed662113@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Sep 2026 09:51:36 +0000
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

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/35202892935

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/b87643cd6e=
76
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1167234


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
