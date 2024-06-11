Received: from forward100c.mail.yandex.net (forward100c.mail.yandex.net [178.154.239.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BD717623D
	for <mptcp@lists.linux.dev>; Tue, 11 Jun 2024 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718108457; cv=none; b=dQiVBi5zC4M2t6aNe7QOTAiZ6d3wcSF8zOKuwJUbajrE7yLxka3kO6xZ1Hl5V8QF3+cvwX7QlXG3jEJYYhJp+d2d7ub/rK95Hw6mMCfNSYHswimeq/39HwvYZSeu/rAJP45Tut4uPecRQPg7Tg/E77ybKAEj4NBkD21EXDl9noY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718108457; c=relaxed/simple;
	bh=4xYd5ZQdoXnS74PKlRtSBC+CZ2e2Z6yGeYZx1p01p2I=;
	h=Message-Id:MIME-Version:From:To:Date:Subject:Content-Type; b=HfjQZzLih+7KfHbeN/NIDxcOfaIvd2yZE12WzplNbSxLY0DR3y8WJN0wKoMUo8G+8zcz0O9zvl8YT+AtlB/x8iOLKrtppgagGrkSUV0W14Tvcaom0maxvOMk97slDOHLb9kT7bWG8egv1ogHZleRsXzXaU2x9DdG1nvkUtVteKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=D/08uNGU; arc=none smtp.client-ip=178.154.239.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="D/08uNGU"
Received: from mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net [IPv6:2a02:6b8:c16:2014:0:640:2712:0])
	by forward100c.mail.yandex.net (Yandex) with ESMTPS id 7A68D60035
	for <mptcp@lists.linux.dev>; Tue, 11 Jun 2024 15:20:44 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id hKdkVQ0SpW20-3q6OMIkD;
	Tue, 11 Jun 2024 15:20:44 +0300
Message-Id: <20240611152044.3q6OMIkD@mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net>
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1718108444; bh=IAv6rUpcKx2YT9lD1jZqKjmO38558ehuqtp3AU84hq8=;
	h=Subject:To:From:Date;
	b=D/08uNGUSCssMiTjgZXp9i4ag3CKAX4AcNmHkEuQEaNCDRx4141cZKfuMbNYgFQU6
	 JnSKDus0UMl2+zK4DGbm8vb+A0GpIJA8xbUYw/w53ADXOMSEodlzFNIzxYpqC5VAfW
	 tq8CnBh8ZUHHw9im2fJrMPI33h0gZPkYTh/frDOM=
Authentication-Results: mail-nwsmtp-smtp-production-main-87.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: vgusev2007@yandex.ru
To: mptcp@lists.linux.dev
Date: 11 Jun 2024 15:20:43 +0300
Subject: Create_on_err  or anything else for auto recreate subflows in mainline kernels
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

Dear all, I don' t understand where is that parameter? I mean create_on_err=
  or anything else for auto recreate subflows. Is it possible to change=
 shceduler?=0D=0A =0D=0AIn the old doc it was in a separate mptcp module,=
 but I don't understand where I can create it or found it in a new kernel=
 (after v 5.6 - for example 6.8 in ubuntu 24.04). =0D=0A =0D=0A =0D=0ANew=
 in v0.92: If you want to re-create subflows after a timeout (e.g., if the=
 NAT-mapping was lost due to idle-time), you can set /sys/module/mptcp_fullmesh/parameters/create_on_err=
 to 1.=0D=0A =0D=0ABest regards.

