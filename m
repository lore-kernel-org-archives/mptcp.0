Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AF23BBE0
	for <mptcp@lists.linux.dev>; Sat, 25 May 2024 13:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716644870; cv=none; b=HOo+vT8Kc++a1X+8gyr/5pB3CReYeRhqA5ryG98WQcMzSxvcfHyXwTbwrzVyo1Tir5YnJcprO+MbdLDgISiScHT7FBCg9ri6aF5aytrV0yyjTCEMlQQGB+xTo+O9phyXQw80BapC0yLODlcNUMPmKAIXjDw8w6cW6pQ5IOOhI6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716644870; c=relaxed/simple;
	bh=fyqbqZllOlgrtVkntvNOOtUY84jsKod6FK2tjb6E8gM=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=qgIdvGfgyLueoJ7ujsXYNJ10OlZ/TWUthqxLhnuKTKeOLcph099BkIybuSn4qWEC1owRt2a5BerpAxtvCQnHN2DN57izt6aCoaj4TNegjUChs2uhEoUwUjxIkuNTPdwX8g46fPv5KNHcJszMASp6yGpZrD4eegoR8U9s6ACFHXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VhCDGj8i; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VhCDGj8i"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f47f0d8ec9so252725ad.3
        for <mptcp@lists.linux.dev>; Sat, 25 May 2024 06:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716644868; x=1717249668; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tTnpp1UKHZgqedkAcr7FP44R5yMTdP6Rt52q3hHK/Ms=;
        b=VhCDGj8iUqznOAgyagAYgug0+/oRLrO5wcnMPr8hdM3NCRh6fqIzCOjRgUbVqlDDXS
         Gn5XqYFEuX16xKLZXe8IJcN3Ab3bB9S6YYPILxZQsT+TAvf6nwnBSb+p+FRCk31gep5Q
         17SqFx0g1EeTBUckVNbf0uApZ4Ezjp0Z9XwSsHHsSEaeIenIjKMu7mX9zdbCVuuuVx7P
         gnbJcof9X1BgXcQhWY/sTlCm6dloL/2y3PqjI4o9WJX4tadnDmbmKM/G3Z9U94Lo1S3w
         D00kQ3Ly1b+0ipayR1QSLZyMECUd8Ln0bliFPgm9e8hmtPstJ4n4mgWGd/5pYGnAtV2r
         p9zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716644868; x=1717249668;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tTnpp1UKHZgqedkAcr7FP44R5yMTdP6Rt52q3hHK/Ms=;
        b=Tkji67p/WAOhpyxjTLT1WitgpH8yT/oYB5W5a1S2i3FyFkcUejjT3vS2ZOOs/CNrUA
         iRfsWbEzvBa/envAubZCgEWTACgReS9aDRYu80u83zMLlhostXwjJi96AVGLzoK2a/pP
         cI3QJ/st3rwKSxYPWeVwmzllhsgvjt3HpnImbJ7bPzs4mCQyJBGl8lk0UNVySOEu0IGH
         AJ5QtYR1ZU6CAsWtDcHUP/TWkAFyiy9tlepaGEXQe0XLsJXs7dli3opxvqOI+tiUjiQc
         tk7T1LpcV/hqAwoNxHgCAodQVjsl9J9DpDY2tWlIWfhQV3T/Qzpfn1G8Kocsh2TLjBl9
         gy+A==
X-Gm-Message-State: AOJu0Yx15kMfVIHLVonMvvkBMliye6Z4f7W2Wo55IgzcNs0hF6e1MztJ
	pwaXJrd4iuCf5xS26yN38kYrnvOq19/vDYuGVdzfweK/MzvHdGET+/re
X-Google-Smtp-Source: AGHT+IHG6XoR07kFz6rxku4du7s6fOIoTIOaNz75qWEKtT6uMXRvriNOyPoa/TulbZ3Oza26euD0Ng==
X-Received: by 2002:a17:903:10a:b0:1f4:6ad9:39de with SMTP id d9443c01a7336-1f46ad941d1mr12633985ad.52.1716644867953;
        Sat, 25 May 2024 06:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([4.227.14.129])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f44c7c5937sm30368155ad.108.2024.05.25.06.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 May 2024 06:47:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1716641976.git.tanggeliang@kylinos.cn>
References: <cover.1716641976.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next_0/4=5D_Squash_?=
 =?UTF-8?Q?to_=22use_helpers_in_lib=2Esh=22_v5?=
Message-ID: <6f1b8c6e-1e6d-8dfd-0c5c-f73597f7fedc@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 May 2024 13:47:46 +0000
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
uns/9235742827

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/2a3ec46fa592
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D855843


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
