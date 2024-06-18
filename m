Received: from mail.salesoptimize.pl (mail.salesoptimize.pl [162.19.245.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EC173459
	for <mptcp@lists.linux.dev>; Tue, 18 Jun 2024 07:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.19.245.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718697074; cv=none; b=Qq+Ojkf7N2W59kJZpTj5MQa6SIAa1BGeoxIuFLkdRnGlgy7Tguz9uWCWkCwrhLU8em1+G1xJKrlnQOrFhhCYe2+HbknMHC092QqnYWKgJ1hFxTRE2/ycTQbqaRffGNxDYNOCQGsXRoBd0+aJAObsOii2zk9HxN1oIGKsBl38r7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718697074; c=relaxed/simple;
	bh=u+y/L6S5UL+8vZAxwL74vV1B6m8M84m9zI1fQPT/Bfs=;
	h=Message-ID:Date:From:To:Subject:MIME-Version:Content-Type; b=sNwSNSFpRab2zKHVhEMwMsKFgmFYkb89vjdBj6UEu8mpmVQYDKLZyrO/605L+lugmIlkFfVybfbbekLNxlag7RVyltCx5IK2l+0iY4MdPMFQhjvpuedv/Llw5NzIoMocY/gXqZP3tED7tYFpW/Cwf6oiRLL1u6OOziNPSYc5fNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=salesoptimize.pl; spf=pass smtp.mailfrom=salesoptimize.pl; dkim=pass (2048-bit key) header.d=salesoptimize.pl header.i=@salesoptimize.pl header.b=U8Lo7kJG; arc=none smtp.client-ip=162.19.245.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=salesoptimize.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=salesoptimize.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=salesoptimize.pl header.i=@salesoptimize.pl header.b="U8Lo7kJG"
Received: by mail.salesoptimize.pl (Postfix, from userid 1002)
	id F29CD471B3; Tue, 18 Jun 2024 09:50:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=salesoptimize.pl;
	s=mail; t=1718697069;
	bh=u+y/L6S5UL+8vZAxwL74vV1B6m8M84m9zI1fQPT/Bfs=;
	h=Date:From:To:Subject:From;
	b=U8Lo7kJGaK9lIJ83Ce7rV4DLfOFLzuBzP0ZqUAMFaNqi1LcnBpskoMJNqkR+KOc1r
	 0EZUNAO4WaaQU8ZIIZk0PysnBpz68d1bmFYcJjvBdx8xHHOUQ9Dy+wI0qXswwlvicm
	 3yvx6yMnW/XJzX9RoM79p3xhNIQWO4BaY2b53lUKjg9b1Ryhf8qVv3fMTWv91wjhv9
	 M4wmBUAm+O0oNh8gzoy1bMaTnBPSyGOPewLQY/1ksff7opiJhKGWXjd1rRTwT1qfMH
	 5aB/b4vdPwwtcHw/GhmpyWfpKV3lZwC/1i9U3rbg8wgJ8ONTtwoR2lx/IyLYJIrJxC
	 ltWluRjajql7g==
Received: by mail.salesoptimize.pl for <mptcp@lists.linux.dev>; Tue, 18 Jun 2024 07:50:48 GMT
Message-ID: <20240618084500-0.1.32.oiof.0.a76q8pk2kr@salesoptimize.pl>
Date: Tue, 18 Jun 2024 07:50:48 GMT
From: "Tomasz Wawrzyniak" <tomasz.wawrzyniak@salesoptimize.pl>
To: <mptcp@lists.linux.dev>
Subject: =?UTF-8?Q?Odroczenie_zap=C5=82aty?=
X-Mailer: mail.salesoptimize.pl
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Szanowni Pa=C5=84stwo,

chcia=C5=82bym zaproponowa=C4=87 mo=C5=BCliwo=C5=9B=C4=87 wyd=C5=82u=C5=BC=
enia okresu sp=C5=82aty za zakupione produkty.

Mogliby=C5=9Bcie z=C5=82o=C5=BCy=C4=87 zam=C3=B3wienie u swojego dostawcy=
, a my dokonamy p=C5=82atno=C5=9Bci w wyznaczonym przez niego terminie. P=
o otrzymaniu p=C5=82atno=C5=9Bci wystawimy Pa=C5=84stwu faktur=C4=99 sprz=
eda=C5=BCy z odroczonym terminem p=C5=82atno=C5=9Bci (30-90 dni).

S=C4=85 Pa=C5=84stwo zainteresowani takim rozwi=C4=85zaniem?


Pozdrawiam
Tomasz Wawrzyniak
