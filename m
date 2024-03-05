Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ACC664AB3
	for <mptcp@lists.linux.dev>; Tue,  5 Mar 2024 12:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709641883; cv=none; b=LbxCFEGN+8pDYFHp8ID7Ueb03L7wv3N1oK29KooKXHSizJh3a2WylEGueF0ZV7sXAWdazb52OcBMOiz3syYAd69pTR+hTz3hiXiWfvR+6ly5Ld0qZwWn1prJdYhYSVDuYBU1kdnRDtMU8lTgIcIKxtYDY7Rculke0VNQcOtCf2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709641883; c=relaxed/simple;
	bh=eujb4sHt4PCvBotTF26O8EEIZPaSAEsewieFQDuWPWs=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=f+fBkEVbrONIVmilRp7syvr3q86xmMKfZeDUKgHQHti9c8yrXnARNy9dABZJDWLx2n4E45zDTlagvB3hGNqSU+lDy8KSbWqtMv/pl0AO16eaUv9Afiq+yVfg/WlVe+WbLQZ14aimpnqf5QCevZiqriWCecSQpM0ug0PRCiqjGiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IxEEOKlI; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IxEEOKlI"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-29b6d52eb3dso134873a91.0
        for <mptcp@lists.linux.dev>; Tue, 05 Mar 2024 04:31:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709641881; x=1710246681; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=apzNMHcYkemrQ1e7RMeJkmI8txMFcS5BCsr7Uv/6+Kw=;
        b=IxEEOKlIimMEKqADM9vq0NLdTOKEOIgCcfq5VOsfCR1M5aPX3Bq3NCEmc5GuEhtQ7/
         b0SCneLLx7k2iVxdJJKXKMkcgLtvwX0UZ3/jC/aN+lqiLDJQpFrvE5CGc+jhAjZf7+EO
         PeZ/plPJEAjuEAjPvT1yMZci5badwVjnC0x88KTJ8xFF+nVeqLPefgU/lmluNByGD0pu
         FfoTvAEHcoNGASIVLQveaBvUG0KFIyDG3bNd8YZ47Ml1INv5jF793QIvb0fZqlHomfIt
         EAgM6Eg2IeDLrbSmH3okFcuNcqPX9xNtJLv3EGJGMwuQLT0UEzAW0dtuOIqe3IauKUbq
         oLWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709641881; x=1710246681;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=apzNMHcYkemrQ1e7RMeJkmI8txMFcS5BCsr7Uv/6+Kw=;
        b=Ri7UjO7sePqb8s9SUzlAyJCV5eF1U/678zOHDjdyjPPWXhEjtarD1ejEeBAYHOyrRp
         MA/k2bKlFDqVxdkWXufojNamM2obl+wTFBGs72Hpjhnl6EnP0CGdlsWDjDVMx+Gxjr8Y
         opR4WTi6ZZ3j6aDQgzvedw7i2AOlo4tlaA5iRYMOxkdO73KEsY71JO0DXBTRfJ2XRxYf
         hYUpKEAuLwJb7T0S4PgL0GACPkP2N+FPuIH6OksPcnPV3ASDOGcejxXo5QbTHMS6WwQf
         HPUeY1yRXOYitNNqqFTjSrVXbWTLyX70mnECF5UzOmcAgXmied8x4hQ93PSuzQ/IkFxL
         Vj5g==
X-Gm-Message-State: AOJu0YzQdFjSxUElhtBM2mv7H7m8GHjFVQpETz1VcFO+Vr6p04bj2GtC
	k08n9tsBzdoKUFVkWcwVu13xb9F5PHVxyCBA0hEeNnpQBddQHAzFO/Pu4ww=
X-Google-Smtp-Source: AGHT+IHwt+S4Dt93EJs4tNygWZLG24TAA+nZGrl4Ku9Iho1vxuOams4grlwBIApdb21NRQMlz+iGuQ==
X-Received: by 2002:a17:902:d4d1:b0:1dc:fce2:3084 with SMTP id o17-20020a170902d4d100b001dcfce23084mr2002967plg.7.1709641880790;
        Tue, 05 Mar 2024 04:31:20 -0800 (PST)
Received: from [127.0.0.1] ([4.227.115.113])
        by smtp.gmail.com with ESMTPSA id i3-20020a170902c94300b001dc95205b56sm10420313pla.53.2024.03.05.04.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 04:31:20 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
References:
 <9a0667639ecd47b8f8bc9370136e53f4d3caef79.1709615883.git.tanggeliang@kylinos.cn>
Subject: Re: selftests: mptcp: print test results with colors: Tests
 Results
Message-ID: <14b7d8b1-a141-71a0-3bea-7d5bac88156c@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 05 Mar 2024 12:31:19 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI (Cirrus) did some validations with a debug kernel and here is its =
report:

- KVM Validation: debug (except selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.=
com/task/6300162599944192
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6300162599944192/summary/summary.txt

- KVM Validation: debug (only selftest_mptcp_join):
  - Success! =E2=9C=85:
  - Task: https://cirrus-ci.com/task/4892787716390912
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/4892787716390912/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bccac410551e


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
