Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7B112C528
	for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000466; cv=none; b=YYAAkXGknGF2f/n8hP7H8tVLGZjr1A0FJ0JSzFwDy6zj0aa+jJP2oalC1CYkWRTIOGPreWnVmPCI+rs8udUBQhSpKI6pdLS2jC3Nu4/amFd67rEGmXHbb/NBiAaJTNh2kn1F4ZrKHSfKW5gYbMposjRWcLvKVdALDZrCFP80wCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000466; c=relaxed/simple;
	bh=aLj+cCDwZJrUDbsYjp7U5YtpFBuIRhc3k9eIb7VdTfs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=evbpuVmhvfzFUhn7Pwo34lHBFui4WeZyirq5mnUdHaG1HFtxSbx3NbrHGxMLJgqUgie+nS32zOwFiqlILEA0KA4q1z9442Krjy0M766Fcz0GGUnhUv480Ezem4xRIWTnv9Q5sfAWNk4+4dKavhk8eyXjzhZzKVCjas6Z/FXZP8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gBh5QKx7; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gBh5QKx7"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-78552105081so47632985a.3
        for <mptcp@lists.linux.dev>; Thu, 15 Feb 2024 04:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708000463; x=1708605263; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rW5Odck8XOK7kNxtBVhg6eVCaVAfP9r9ecBj1u6WTo=;
        b=gBh5QKx7KsK7DxmdT1pNYvPEkc0Sjna9BoU4HGMw2E3n9mfnrrC2Kp3NfyBgtRhNew
         N5dr9/z9yaOKTb8klZclNCd0xMhnLofy17jWIBJ/9PF5DoJrzWoiFqBd8CcY4kJSiq+x
         JSgJPj00HAv7sRnpynhDl1ziWLtLiKNWBVIYvEihVGXlpEXmtsAXgPblR0zhBrXxKZEq
         GoxfhYPnNY5UaqEzz7MBnsAaIHU0qDDYepls3uX/uRBW97xUhqyjqDZ4eluq1bBeiOei
         k/1DqZAsvhOImSm6qnBYq7GZmRFZ0oVcQuHLgWq1zr8Wrwnf29TxSw4lktkNLoa7CABF
         PjHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000463; x=1708605263;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0rW5Odck8XOK7kNxtBVhg6eVCaVAfP9r9ecBj1u6WTo=;
        b=Apn7FtCovOJxAj0SyJmqhDrP3n2J6ZV72PwD+GvBl3EeyA3wvGkENGr6R6P7mCxM9Q
         vhPhcBMSou8RRk9VVUy9Xst0lZUIEAMdy1eSLUcVfneeGIk3o3Nrrf7OcZ/XdvJxavm5
         m+vv5Oa6krUzoG6SVa7gjf87ObYnxXFSbFoRyUszelAPpQY/VRPGGcXshpACjfavvMp1
         vaCT5nckCyAS9yCP0CbCPW3yol4G3KCrFI221nyyVcNjAbkzJ23mDIo1IM9AsrUtdjvY
         JZj28bVDAFil2AuzCnI7GRIcpAWMv4IDMRR/t7kTXXN5lJcr5SOXL+cm+bE1cuL7di+w
         sHvw==
X-Gm-Message-State: AOJu0YxFPstJtNouKO0v/R0586QWt6Et2CE+r+PRs6FQygMKueuAN5TU
	fbrd33mQSTsOEbgdLWUd6Q0NXdZLFUnh1Jkh+sgM26q7uyyH9viw1FBjlu2gLQ==
X-Google-Smtp-Source: AGHT+IF74HWCSbdREAx31m/5tGQycUOhr1+VkgYCvtqqU8o3L/N/5qltZBO6HTI+UnaLHeqfPS0Chg==
X-Received: by 2002:a05:6214:4884:b0:68c:5a42:41a3 with SMTP id pc4-20020a056214488400b0068c5a4241a3mr2251554qvb.34.1708000463107;
        Thu, 15 Feb 2024 04:34:23 -0800 (PST)
Received: from [127.0.0.1] ([172.183.113.200])
        by smtp.gmail.com with ESMTPSA id y15-20020ad445af000000b0068c968c3b33sm609977qvu.20.2024.02.15.04.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Feb 2024 04:34:22 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
References: <20240215-mptcp-check-protocol-v4-3-16e932665e21@kernel.org>
Subject: Re: mptcp: check the protocol in mptcp_sk() with DEBUG_NET: Tests
 Results
Message-ID: <02df85b2-afda-085d-8141-cb48739d839c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Feb 2024 12:34:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (GitHub Action) did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/7915472729

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/96cb1155ed44


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

For more details:

    https://github.=
com/multipath-tcp/mptcp-upstream-virtme-docker


Please note that despite =
all the efforts that have been already done to have a
stable tests suite when executed on a public CI like here, it is possible =
some
reported issues are not due to your modifications. Still, do not =
hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts (NGI0 Core)
