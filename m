Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8CCDF59
	for <mptcp@lists.linux.dev>; Tue, 25 Feb 2025 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443644; cv=none; b=iclBmE5X54GfU1REhl14VyfdwkYrFspWBbGV74vpxviTPB4a0/DdyQbrmJIOJOEKqrJjrpsBQL8n5fcSWrB1DmXBhptyaHU5oc190mj3DqK6akmc12h7PFbklxcJxLKTraUCan+VvdpsNQavHMV0PmIf6j8RvASHr2jNt/C820A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443644; c=relaxed/simple;
	bh=OznF6ckB2lt3PT+d0/8Q2N0VLllnFloobAOtLpDlD1E=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=KtBYHsLZt2OfidBcHjmESs7qyRhsJMaLh9PIGVSTyyvze5a7IXUvGVy7+agh/M9xOFNLiy/6qizfBVKop0yrv1TBnrrxGHkvktkXtPjdhlDABOEiW2r4R8V9Z9L7PJZ11l54nxHhJgqx6t5ukXesnzfwYohJfGOjD5b/S4TGI1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AqOB7DWi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AqOB7DWi"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-22185cddbffso101440545ad.1
        for <mptcp@lists.linux.dev>; Mon, 24 Feb 2025 16:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740443643; x=1741048443; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OAouJqTn8katwL0+4chuPAalK5Cz7Iepz6BSiiwGdW4=;
        b=AqOB7DWiUgIpTSByur5Tc4QmS0wxNMk071D/3F4t6yYuyORNjKcUv0lggfzETXN7Jd
         3sEYWiUXC9ai9l9vJPnbUdEvKTyfLj68COKhTR/zsTU66pSFZ9SyUmTa48284sIU5KRg
         AAb5eji4Q2dkIEpeB5hD29RTv0FhlT5FDl3sglUHY5kg9iDzmSmkZmQd15VurP5M+/w6
         nC3LLEWgithBl19yp23eYDVtMC2o3yJlvEiM1LnsDlib/gDm86aN8adtqjndZsOW0Xgv
         z64lXLIgWaNbdM6dL8gb+ZP8VKHhWUJg81e63GeUSldcCYcpt7B7KINCwzfZ4xksRWiq
         tiPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740443643; x=1741048443;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OAouJqTn8katwL0+4chuPAalK5Cz7Iepz6BSiiwGdW4=;
        b=oPY8GQbmRcnzee5iFICEmrjGjUb2iRybqd5cR1Ddjl5Qs2XxCFTjFp2zyru0wrol9f
         epR04IcpUNcp43RcB4J4M3cobH0wlirrDnt9YJhPE7To00zoz0J5UAWBy5gg/zIDHQFQ
         ej7AUDZiWGkiKCOhI7xXPHGUP2tlADm1ruYZ7DsRaUGypoJlbDtB8TSHTpwdssL1eTjs
         VpDigUEztceWa2EEo0fBeEfnZI0dE70JdLhV0/w69MdkDfLESCmDkzPIBUaBrBZXiOuY
         qhVFKNcSVF9dsUi0n6+YNpeLPCz6Df2MtF3YnQF7Sn6p7mkJlEgB2lBhwlSUku2+cXx+
         w9Ug==
X-Gm-Message-State: AOJu0Yzbs7LEh1gASlRx2e/BwxEcr9xsMh+xFtj0jZDDji9nt630PrjW
	WCOvg2OioVGRncsP/0YFPRK0R0BbnANuToO05kSJC+gRSrb8qbw=
X-Gm-Gg: ASbGncvl0UfAAl0PgYwSkZ+Dne1vJ/xRBVMdch4tTnngbJciU9xYRTQeijqzGrDiYe4
	DT+ZucxQfsSLFdv2Z2Psu2zoccIF8Kjzt5atnKjbSNc8V5JLma9HP5as2SSqQXmaZP5dtCoXupA
	TdPYMS2yMOtkBomv1gyieuLYUd/jQRTsAg0jGIzzcg/E7JH5DTw85zIMIoTV/S45sL3CQ9+b4vS
	mSkAKuOVXUC37bUAuus49X78n/nfo0/np10xEaWFhpl9cRMteqXqDC2NmOVIj3IP47zdt4TbLY1
	p1NVVXwE8hpNyfn3K97ogLwTiZ1yp7T7zepJrwM=
X-Google-Smtp-Source: AGHT+IEsNer7uq1GjIIvZjIhtdW9pE1ox5BdN/d8ipsR7o/YpROmRUrlM2HUb2PZSZurXs4eUXkm9g==
X-Received: by 2002:a05:6a00:1906:b0:730:940f:4fbf with SMTP id d2e1a72fcca58-73425b39e17mr28474315b3a.2.1740443642527;
        Mon, 24 Feb 2025 16:34:02 -0800 (PST)
Received: from [127.0.0.1] ([52.234.33.214])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7347a7f9b67sm259545b3a.108.2025.02.24.16.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 16:34:01 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Krister Johansen <kjlx@templeofstupid.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250224232012.GA7359@templeofstupid.com>
References: <20250224232012.GA7359@templeofstupid.com>
Subject: Re: [PATCH v2 mptcp] mptcp: fix 'scheduling while atomic' in
 mptcp_pm_nl_append_new_local_addr
Message-ID: <7a74349d-d312-451c-2421-a08e7d49a56f@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Feb 2025 00:34:01 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Krister,

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
uns/13510193894

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/b89b385a81ca
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D937276


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
