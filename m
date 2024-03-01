Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7162575F
	for <mptcp@lists.linux.dev>; Fri,  1 Mar 2024 18:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709318450; cv=none; b=Q9MsWa2x3M4OEwjuHOhPeYnpbL0qLSps4ui08AjnpxFTQ7Y71+Wgc6uVKruOW5ZjS1OGQjrz1HtQpJTisRiWirP4f+8ZpWMSYJQw4RJQmpHttIi9gKjjPIBcr4pRZKbu7In39xQvagfopOf/kkt8J4KretdZvtr0c247A3PCCy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709318450; c=relaxed/simple;
	bh=jzo3a2Pq0DuyBLPShpnPcELtLbBOc9nx8ZGk0ScJbaA=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=QRj/ZhqYjLU9USnfCj5YGx3fB4vi5GrR6OEyOKILIGtq7wQQ8kIw5qQXwnbPZsOKp14vSxuRovh7ev4vHjiZX6/FbEk7fuZsOeOA/dU07icS6y46y7wb4z39eDFCcNQMIL1a0SnoJBB53VmxBEjdOVCwPE/ihnmVe/D9ox6ulBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0u3Fkd1; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0u3Fkd1"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3c1af1e8b7eso1300336b6e.2
        for <mptcp@lists.linux.dev>; Fri, 01 Mar 2024 10:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709318447; x=1709923247; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hRfmF0Fr2n/41ywtJfFYrMY/Qb15E6jD/dVJF7L/m6I=;
        b=W0u3Fkd1iCY1T+msmt+Wlrtc6XVPYmZhGRJ5YHmjjthdH2or0OMOOy8mpjmDuDNBkQ
         +fe4241LNtCBkzbWqwFpRAxbKwIMFOlUavY9rBdEmXfzUQgUMXN36afc36xfZmeN2vO6
         UJv8cigGFXRNhW4WRrnlvqpDk6B4S1Lomxj3moZfo0nqo4z2QJ6tm6ikjps1SU9Xc8KY
         TgwA2KQKUNVOvuFIdSRK8NRWebOlrle1WKA1AH6r4x80Vt0keRIr2+DzXpepGEk2jl62
         8jtkzgxLUhn4XG7HRgnOLl6c2CNZodPxhB/IU7u/AytbnBnqEQc+Jl2RkUT23T3+8IaA
         orJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709318447; x=1709923247;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hRfmF0Fr2n/41ywtJfFYrMY/Qb15E6jD/dVJF7L/m6I=;
        b=apr2fE8V07ir9wcgcACAUCFzx/Fn/i/U6ZRraRMVs+LCyMv2Qyk65gJNnxQM6ybUbL
         WBQa3nTM/MywieHPFCk2mpo15C2tI5B5ZfQiNA24zuBlbdTwnDIwwDRiVfFcHM822ydr
         Yb0GqghNoedSjmLCYXsyOXcBDZA1aiUNOvPWarIZw0eF738ZpclNrpE58Jju8b4dOAxC
         8R+e3AIQSu7AaeDAV9PzMWToUb8fx2ZYhW4XXsk2ZMW0F7LFBteet32tx47+iFKQNtcR
         UNNYQ5g1C+XylclFWZ3Qw5xPXbmKT0BvqDh+LChqFl0scrnvoq4KI4tMglc3i9EblEgL
         2kkg==
X-Gm-Message-State: AOJu0YyLMXg8rcHRCiUZQbIWagTT1WJnlE7NJbBgsWT0A3LbIbMV/ynH
	4KThechELjb4fy7CrD2bEvOkyFXgHThRtmXXole/C1YUmFD2Xa4=
X-Google-Smtp-Source: AGHT+IG9bUamF27196XDBBPfaQdbe7S3n7SKhbWUgBxK5MhWr9CjdKo+29bMdp0rvxp5DXcCFDllkg==
X-Received: by 2002:a05:6808:11c3:b0:3c1:9c5d:3a4 with SMTP id p3-20020a05680811c300b003c19c5d03a4mr2758077oiv.34.1709318447336;
        Fri, 01 Mar 2024 10:40:47 -0800 (PST)
Received: from [127.0.0.1] ([172.183.74.1])
        by smtp.gmail.com with ESMTPSA id z23-20020ac86b97000000b0042e851b63e1sm1934895qts.43.2024.03.01.10.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 10:40:47 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20240301163846.1370114-2-matttbe@kernel.org>
References: <20240301163846.1370114-2-matttbe@kernel.org>
Subject: Re: selftests: mptcp: diag: avoid extra waiting: Tests Results
Message-ID: <add2238e-77fc-0062-060c-fcc2822215a8@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 01 Mar 2024 18:40:46 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Matthieu,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/4921225164619776
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4921225164619776/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/6047125071462400
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/6047125071462400/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/4ee0d83081ea


If there are some issues, you can reproduce them using the same environment=
 as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
