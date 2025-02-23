Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F903BE5E
	for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 15:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740324884; cv=none; b=o84LPzBr01ut8Z1EVzEk1xlyrA3Og7BaU2FcCv8SghluLTzX1N+4qDKA7xUi1l5eTVrYJmwJAim1ES5qvrhk0cuDjvL1hX0Va8LXdQnQfbBSRJ/I0CLGHaB0rfh8+ysIsmPeRKXHQ7ucD1F8BUIpJMuEfONxbG7HBv8Q+qlFekI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740324884; c=relaxed/simple;
	bh=UyRObLzKP+oMgQa8SvEMA8dnS93TDsXuphbNldARF5Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=jy8rRNm03TYJkwZz0UVdR7G7v9hOmgf3f/eNg0gSiTt/XJvl56tyHhm/q1waElHroGa5jyNAx1PgenvPmdY+8eYGZjwSoTTwmPJWQA3B+iBf5hqOVr684bkUqF0HclA8m0YVIKsLyMCehiVUeYH6JCW/eoUS+Uf5sISPdKxF+Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7v0FZ0e; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7v0FZ0e"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e68943a295so32574656d6.0
        for <mptcp@lists.linux.dev>; Sun, 23 Feb 2025 07:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740324882; x=1740929682; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Qrdo0710/yLzjdgnCe3CNjmHyuSGwRhr6vOLVbTYDY=;
        b=Z7v0FZ0ejPvd3D1xtJGClmtWZ2Fl36Afr6OXtoPMnSVZulVqNRbwEEfNwKViplzZvn
         PHcscLRAiw92KaH4Xh858HnfF4dpSfsbWtsPELcG3vdAM0MSDaQCtdza4bPFAFgp8G+P
         /7L6cNb1XCdqTHaIdBmSB5I/Ow6cEAu6p6itn/wF0UmFxmuvVN6IqL/EZFyNWHkv1o0b
         SUbi94rU2CfTAhjIW+qy2wp2GlqqKgO2Cr8YbrZnV9ZpTqOvoHWSCoiID1RXleKTIiQd
         98XLS8gjQ9Am1tstNUL1g/2bpYGmxVfNJkVmpRpz9V8lMJ4OKaALpuJfaykyHjshEnhs
         M50w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740324882; x=1740929682;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Qrdo0710/yLzjdgnCe3CNjmHyuSGwRhr6vOLVbTYDY=;
        b=mqiPsjUnrotBvzZpatWDqTocnns0vlUWIahJOH2fWgm3o4Qngo59nZSUGPW6PdicIO
         1QWDxDsOqSwJFhlI0qNgjKMMCVLZRs3R6rloYhB3OeHNxaqmD/Xfd5P68TFuUVma2JBb
         5MUnvM3bthsAvJETR47oeiS8GGFEPAe8Q+92SiwHu7/oNGlJBIOV3UUpVboncjyjLbgC
         RuA4CZM3CTgFfQ1eCrVtVJ4/npdYk1KD/+W5pKrac4QBDaOQJLBiyj1D0PpxTgTzzZuD
         M/AnA1p4mBKL3yp6DI8p1F7dRcxKZv3eMgUt/ll0UcQtcBW8FW/HRMMUP4X0zWsQU+Lq
         e7Zw==
X-Gm-Message-State: AOJu0YxjL9fWwTzfMPy++hR2Ar5Vhsu3iU70k3lVjcaqa8l3aODIYWPY
	/k0tpCwz4mEqz0KVTHjuijl9pMhXt9YPxQNBJN4JhGyGq9RTCrNyxPIgus4=
X-Gm-Gg: ASbGnctK+fah4K856sUI9IZzYGy1o3VlyVnlrzvua4fVT0q4kOwQV2X6r8mhx7djb74
	Rg211ISoAMIBDSTyf7AIoWp4v+nrJPp2H+p8zoLacfoKcq0gAAtth9K/BvMNDPpU1isIV/Vhoq2
	/GLGu7wXyrGhmXOEOwTv5eDi+b/+9DLU7RaUScYpbulJrHrMemwOZT+4WzW7fBOC98+r9w/Qx6W
	nSiQ9WE16nEs3hMLVMNjnTPgoVFCSf1Wm9Xp0RI9cek/Vg1PO5upavw9LBEZKzXrAdNOkPNMWAR
	5JVVnKK4SF85voAinA72eEMingrvKPkvJZillUdB6A==
X-Google-Smtp-Source: AGHT+IGX6VNFSzj+VOlGunfRPaS93YIsX0SkrTNw2GWwWXa//uLW0cia1ZvXxl1enNzQc+uqOngb7g==
X-Received: by 2002:a05:6214:da2:b0:6e6:6686:afcf with SMTP id 6a1803df08f44-6e6b003f6d3mr130383206d6.4.1740324882055;
        Sun, 23 Feb 2025 07:34:42 -0800 (PST)
Received: from [127.0.0.1] ([172.183.174.156])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-471fe6c81e4sm70333171cf.44.2025.02.23.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Feb 2025 07:34:41 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1740320007.git.tanggeliang@kylinos.cn>
References: <cover.1740320007.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 00/13] BPF path manager, part 4
Message-ID: <d1bb0598-ee14-8e2f-125f-fdde0efd9788@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sun, 23 Feb 2025 15:34:40 +0000
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
uns/13484061884

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ba9a44169d90
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D936802


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
