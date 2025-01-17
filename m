Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFAA1F76DA
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 07:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100560; cv=none; b=vGH7Ed9jqttfFidFJQKQQrL7xZUIKXJhhcL0jI9fhp8hvZJDdpy+zzj7PIuaSxCsiNTRnKMgkEecXsZELHLxpwt1SG6tnV/CHFywxHIZ5g2uCrVGzK/A+pzUj0JasRg8Dyoc8KA0DIIvwriVCSeF6qJohiGAhC0KnliVgl8Ll/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100560; c=relaxed/simple;
	bh=T7Q5lJqfq2tXc3MggPj6ecSRjzjy3eX7JE3TwcFjaL8=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=NXn6/WuigSx79oufvcG0zGm4f5bX5jn1k3BkP8i+Rkh7fL7xcuOLltaWXl8mUP7MDqvOMCLwSw/CqVTCiX7qalMWReJiOigWU4tUpoifZa8UvFkDIYbDrCTEzXpN0jN1zlroxoAYfFmVgsXBVlvAieSpb5yXNLgJM9al7LNRzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U5VwjJDD; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U5VwjJDD"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-216426b0865so31155765ad.0
        for <mptcp@lists.linux.dev>; Thu, 16 Jan 2025 23:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737100558; x=1737705358; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0APWZWFcoYqIqt/f46zYYYsnOR+i7VPIh6+Fulvkh3k=;
        b=U5VwjJDD30niFYigfe6c6JIsmC8G1T8FtAGQnabBVjlsEauHf9gjJ8SdgGCj67a/h9
         9piCzsScMZrzXBiBbxOv8USc6IQ8sWRk65UpwF2Un/6tEf95DjEcV2JpavlLFrDtAQSa
         NsZmBQpNfFT0K7fsh28Q+h7OVS7tPxJJV5hDnbBry9MgsaCf9WqdQv+3vQnjoozT4zV5
         x1U+hK+ZE0sIPeqaZ1lqtoP9t+IT6yVIOouds8MgddlsxMLpG4T5n7RkdOfqX/hzH1GD
         qC+idJEO/H6fuB4Du1C2b5sRiDAnjxEI8muI3gsAOoYTioTPfvIBvPgCzxfdygLv6z1e
         mBtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737100558; x=1737705358;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0APWZWFcoYqIqt/f46zYYYsnOR+i7VPIh6+Fulvkh3k=;
        b=UfREdF0fPstooAMOgNdNd0BRG22zICM58K7zP5gXbf8FM0uBl+RrT1XJs/7fjQxe7R
         vjGNmIDa4FXZvTU5P45k6b7DNkAeN5pEsb/tZN2zb/m8NIcKdLtOPVvk0mlvmm0vypRK
         2V41pN3Asc50CebMXISIcDmCsPIU+Ejb0QLowB9kHPm6GV3icuXUjZQ62tsL26pmPJP9
         hwW3Y0YsyUjcuzL4qXicV+0a1elPtXR6mxt2DCRp8DSzPjVd2kjd9BX8oZ/2KxdIKliS
         4vXxyLP/7CntDaX2g6vfRx8IDFBAcPVDMoTfXUocXperLN/QOjXBfVQstJTuZ2XbUazG
         77Cw==
X-Gm-Message-State: AOJu0YwVaYPYc73SI0q6sHVwDVwvrYPlNVtSju4l5RqKlo2XkRelQlXl
	Y5KKoje7/aSfmXnWs0ktO0jEmIEjCHvU/489aLFbcegDJxVqHLzWUU1A
X-Gm-Gg: ASbGnctZJ41Tuz7jWSzKXia62F0k8vf3CBU0VrVvh0tkVyTkYP4aVCh2i95EyanyPuo
	4eMlZmaClyqX4Cgq+eJ+Xd5bzw5/z9tM+PkZlDqvm5ryTPK5jrQDk6HoEyfaKDVdrDNIFVLDxbq
	09uROF2GlXpwtumab47WA8buKbKyiJWfk5doEi8SqvgqCtUiUGnhWuI5Z+h13p78pXSOiqV0EuM
	2TdfA9VKEyqaoaexmQbfDFfN64BcLqbOa0suIGX8jk0VSv+C9+P/rjnmHGQS6SrxlXIfA==
X-Google-Smtp-Source: AGHT+IGKmZu796nFZ+AfqfjCRkIPOOiegXSkIm0CdhNEYapnOLJLdVArc+te3bNh9wkIseL4TrE8Vw==
X-Received: by 2002:a05:6a20:9191:b0:1e6:8f10:8ba2 with SMTP id adf61e73a8af0-1eb2145eab3mr2625956637.9.1737100557991;
        Thu, 16 Jan 2025 23:55:57 -0800 (PST)
Received: from [127.0.0.1] ([52.234.42.147])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcc322169sm1201954a12.22.2025.01.16.23.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 23:55:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Gang Yan <yangang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com>
References: <tencent_EE06C3EF8440C6905D8EC0B94E3E4A589905@qq.com>
Subject: Re: [mptcp-next] selftests: mptcp: cover 'mptcp_diag_dump_one' in
 mptcp_sockopt
Message-ID: <0091c2ae-e2e5-04e8-bd0b-6749c05a8589@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jan 2025 07:55:56 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Gang,

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
uns/12824293005

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ee9495d612db
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D926359


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
