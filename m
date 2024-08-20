Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C1118B496
	for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 09:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724147009; cv=none; b=nuno4Fmro6G8fQFz9lYVhkTZlPI3FUZ8yNnzVdfuUeCfsd4An5gFKMqaS4uDTOzkk270Tkl7IzFAUs5PW7qC7fbEVKa8d4GCRq+Dx7Qht0Af4DD+LZCEqAMTUbFhVCVPasTZUTNnEzM60ENVfLPUVYj4GJXA3gZ+o8D98s5+9LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724147009; c=relaxed/simple;
	bh=YEfNnbFwbzYwgUJaItXC4c0m5LYlAj7/JHMPorxqfGY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=E/vZOCmKw2hqlswDjS5PiK68MVZEnBsOVlsirIm6NErudEMER8S+r2KzgMuC84E6QwqWFPj8wT1ysjlu6AQTqon4fuzwfshbalrCx69vXaTW4x7L3aGl14IAJY+vtynG66rMO0uzRk8tuwHn+B5ug4BZmaPKW/Z+Pw0UDv+F64E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=el7TrC5w; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="el7TrC5w"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-44feaa08040so28769751cf.2
        for <mptcp@lists.linux.dev>; Tue, 20 Aug 2024 02:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724147007; x=1724751807; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xPB3d6vewEhL3ShSknXtY/+F4DDsLqTnTIgTx3nwIU4=;
        b=el7TrC5wd+EKZcAuFWbE/r2TNH0KOYnYS9x0iHopK080PyUh73XTOHB+PCc6EW1gg9
         LKEAGHA5nLvXsajkMLPNDBcSuehgNCCJzKVVEv0f343mNIh4E7J+OdxVLubpjErmg8Na
         P9+4FCwnRTMm1wXQGEbu1jPIF9WyoAE81bA/hl40g01ZBb4KrcOswe/Ubar+QeFxghi+
         WLhVED51ZKumpsoQaj/oEcxAZQ2BBddNdJ6UNvG7D4kGGx9T+K6aiGQGjUP8pzDGgOZE
         JBDnaPkXbS27bcYsGobsmnDAXb8TEFpKiEEPbGn0emNF8cbucPFuLUK6l6GeMRTZNzmG
         tYGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724147007; x=1724751807;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xPB3d6vewEhL3ShSknXtY/+F4DDsLqTnTIgTx3nwIU4=;
        b=uehfr4QszdKFMe0GolR4WXUT/CXjOAVUgV7gGp5+eN8fnipDJrS/h/sClElpoHMVO3
         OdsT8nvDLq9Vd9Ll2ZlvW16TDiF2EGLcL2l7JcosDZNAtKH8Fx2v8kBtDjXkXuIgncsu
         ILLAqT3VJ7CxRpe71OWKF5ybLXkqO9oldrwo49UbGvhRUGi9cd94H0gUlp5ciSVaRr2C
         RKQZ4o76afRvpdryIXmFFRoln3kmwuvWKxM5k1neW9u+uNyF7HoCfHO47rMuNoUuBAyp
         iOXuSMRXVeN+h1PvYNn3Xl33Ip2t8PYE3UhALCYLqNdx844Kl+X+cpV9UHa60HSiY8nV
         cEKQ==
X-Gm-Message-State: AOJu0YxRzMOu3QjTohOyrGDiYJ6f4CXjWzHCTtYUry4PvddfAJdlq1tI
	P9UeDFMYJHa2LmtG+HRZLf8c1HA4Ll+Zh+P1UlnBg/GdzJBLR+T5RA2C
X-Google-Smtp-Source: AGHT+IGcN60dLCJ82klJlGEgAxkyCjVfOcEwCVEI+obDAW7aHpmzqcmnu5igzeiANPmAqDrUqUS8WQ==
X-Received: by 2002:a05:622a:4188:b0:446:67ad:ed5e with SMTP id d75a77b69052e-4537428fbb9mr158317111cf.30.1724147006902;
        Tue, 20 Aug 2024 02:43:26 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.54.159])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4536a04e676sm48514651cf.67.2024.08.20.02.43.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:43:26 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1724142917.git.tanggeliang@kylinos.cn>
References: <cover.1724142917.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/2=5D_fixes_f?=
 =?UTF-8?Q?or_=22new_MPTCP_subflow_subtest_v4=22?=
Message-ID: <42f8844f-7650-ecdd-7f1e-4abfd72742de@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Aug 2024 09:43:25 +0000
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
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/10468558763

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/72588d7921f4
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D881229


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
