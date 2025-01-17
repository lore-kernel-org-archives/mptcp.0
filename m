Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9DA1CEAC8
	for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737110789; cv=none; b=FxYNQ7nWl4jV6fBGEL4n2Nmp/MvrhZADLOb7vnTlw6Eowd8htfF5ZAHcH9Y6oN8mwOmbFL3w9lEq9+77B01QQSXQ3yxEmhy8H2VuF+TUzcNGANcLWLKJ+JjQaLguQw6Gu8vMNPcimmL6R5ax53OSIVSbBdavdnJgQRUKvAXaNO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737110789; c=relaxed/simple;
	bh=Z9Mrd6+HZtOTfcOyRBLkT/QkcI35FecbhZ3dneYYVx0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=Eb9847BIWIp+lexrKU2VDOQ2mXt6aqo8HPKFpf/DiqDazpMvbn0wjlIEe5lW10y2niegxAQZAQClHHtQRKseyze6DaDLbtgnJPFljNClvGKreoENnZOSMJp9JCKesLpO+UHifZJ5Khj6QyuMrjKp/6LG7PpJ4+X57nJt117HtfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSKt8KOo; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSKt8KOo"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-467a63f5d1cso18497421cf.0
        for <mptcp@lists.linux.dev>; Fri, 17 Jan 2025 02:46:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737110787; x=1737715587; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dOTrwz2IeKyluizhD2dAoccQEDl4psBVQzgSBsZ6K0g=;
        b=iSKt8KOoo5+ZQ44RSgQO/idbBcDeXdwlSL7SJ7lltOPHnPgbGpDHMnHwLT9VQ0G5b3
         X0FH62+UTu4zg2b4pG0YDrTkHpdnFPMRyqvwxWlpfj4mrPcy3V3MUKIzOsSegQJEDBxQ
         9WnkOngFaUwI9s6aEEgPRdZ2eEb3wOKaxwz2bmspH+X3+lbH3NTvi8BcqEpbORV6xT3Y
         IBrnXT6GoOpzre5rN1WFz1BK0KLFfvUcMO/h411WqepEMONrpkaloZBpHMbS6ouPK0D1
         N0BT6sCiZsV7ySTi5lg61y8dfDgxcTw/4Bw7sV3FVqBUvMlkkbKzY9aVhPgy/yHjAx/t
         tPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737110787; x=1737715587;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dOTrwz2IeKyluizhD2dAoccQEDl4psBVQzgSBsZ6K0g=;
        b=l5hQlFERr86MCix4xZoT/YCLMxmt1JKJwYiVAIaOPZu3lNkc4kv/yzkJnb5nbVHIVc
         x4DRzfaqJNf4ofM4q4pmYYRBufwncv3X5HLwYQAfrZiOrebrk2TdEbicK0YmXdjxq6zI
         3T6SPwl9nLLjpKHL4Z8hZFo5l0FVq9BYFVrw22o8zSCeQdY2IC3+TIEiLfVMfK43CEam
         oAsEVpJ8JXM7zNOP5CCmZzJ5frDoLmaDn059vYvev41LnGgxzex019/pt6VuNYMHK1vx
         9clJWZWtQgdK3hBOALZyt0N6nfgBRK6/PEu5WoJ9GFGe/xTynUqwd48x+9AAnkh8cugU
         O0kw==
X-Gm-Message-State: AOJu0YxiIYl/WoHwKUR7l09DEnr64hViDVFJsKZyhq9PibFSQP0ryY/O
	TiWjLDNzKaDkjZnIW50+i/3DrLC7XG7OfjfgBV6aWikJTrDW5ERcCHyU0Fc=
X-Gm-Gg: ASbGnct+Fa9o8LFtcvAWHvpTiP6h4FTDpI4vxX2TtLWG2I3dV07pZ52A2P4u0odj58T
	TUjtSdteKfAFkWyYxqGVqOE7oXzu3wGs51FpGpJde+evC0EljJ1KhrpxiUCA4Tbh31q1l2PWaU4
	6eNdIRfuo1UHvYVMrBBFZqWXH066CwREFBrWPVTTaRyBPpa05y878KXmqo4bhMtm9WQgRicWJqz
	4bb5JrW8iHzD34EG6imHdIJ5ol5GSYCLiMD+CNkWCFlKBf7QRNcqR7UgOHF1QW1+F96k/Q=
X-Google-Smtp-Source: AGHT+IEsKsvFMTkFOfhI2ENQw0MgP6JpVFhv+z01+Tw6YU83Sl6N1KP9UdRPHPvxsEUTTm1I9DBh4w==
X-Received: by 2002:ac8:5852:0:b0:46c:71f6:7aa5 with SMTP id d75a77b69052e-46e12c394e1mr33040061cf.41.1737110787242;
        Fri, 17 Jan 2025 02:46:27 -0800 (PST)
Received: from [127.0.0.1] ([20.102.223.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e102ec6cfsm10039731cf.3.2025.01.17.02.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2025 02:46:26 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
References: <20250117-mptcp-issue-540-v2-0-a194740fb380@kernel.org>
Subject: Re: [PATCH mptcp-net v2 0/3] mptcp: pm: only set fullmesh for
 subflow endp
Message-ID: <ca92bcaf-1728-c02a-fa6b-4b54824bdbb9@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jan 2025 10:46:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Critical: 1 Call Trace(s) =E2=9D=8C
- KVM Validation: btf-normal (only =
bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only =
bpftest_all): Success! =E2=9C=85
- Task: https://github.=
com/multipath-tcp/mptcp_net-next/actions/runs/12826636303

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0abf0f42d0e0
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D926404


If there are some issues, you can=
 reproduce them using the same environment as
the one used by the CI thanks=
 to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
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
