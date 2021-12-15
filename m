Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3422CB3
	for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 16:01:24 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id g18so21080013pfk.5
        for <mptcp@lists.linux.dev>; Wed, 15 Dec 2021 08:01:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=GnfvR9xLWXVP0FeaqmGdwZ5CRTixjwQd5BuG2ptz03g=;
        b=W5l0KnPqhLaBDkafAZc6O6n48tPWdIU0gye3n8ipjV1jE1VhcYLTC/vQXbZS7kUfu/
         mWhdXR2QME/uKsXZsUBViOtlOG9BLQ/LfW7fU3eXIWWEu3mRHKBAoIQ2XghA1pQKrId3
         2TuxWvInQd4Q38RY7nok47o+DYF0dGsHF5xGzVrSW7yS21WXeIdzE/TbzUeZ6IFWa1DT
         vgEFrboUbDopl6j2b9XO96qtUJZ6xPK39cgVpBaLthzWKb/KPSLjyvvY/eO1mW3jBFJ7
         cXuddqDK+A0eh2+S+JWBRg124DGUcWBqA5p/HelJIQqIJH+duKRbVHF+mwIuMHnyaSb0
         JANg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=GnfvR9xLWXVP0FeaqmGdwZ5CRTixjwQd5BuG2ptz03g=;
        b=P1T6gsCa/J6MInFB0pVRNy441hw0oYmZOysohOrnWyTYUSs51yIDO/igPsZvXhdC1S
         tk/gN89TRYHQJ+huiey7wObErrdm+U4EFL37E/Kcq5mubyffDYmpP8Vj3qEPzCrIH+h+
         HlckUS1KqzYJBzEZCwQQ/+hg0fcUnZMrRyOtNWPxxWS3/dt1dvocE1T1mqLX9EINXa7z
         2+8FCz7kplgPaor0qlXyTAvVO5lmNkM6YoXaBtFTivE+wdOFZnxo8kQ+O1hcxFxqoAi+
         wGQ+kpPpoIC1cwS+m+I78YdfxwqlJbS1yYhJ765pedFEPSOqXZO/eW6jUiLbxEgqZ0Y8
         0YbA==
X-Gm-Message-State: AOAM531FBbF4C4Re6JpgcQLoj/CwbJHOSxhITmt4ycP8KBLywHHjb1P+
	F7OyHKwUUbIebtjdRsTusg==
X-Google-Smtp-Source: ABdhPJwd/UpfsZ+ss3s6XCPrnHc3Zk/KGL5p5GlzBnDq7NMNuXdLnyqaZVSAznjkfGr+n4eTR/CyXw==
X-Received: by 2002:a63:7986:: with SMTP id u128mr8667988pgc.204.1639584083250;
        Wed, 15 Dec 2021 08:01:23 -0800 (PST)
Received: from [127.0.0.1] ([52.156.81.11])
        by smtp.gmail.com with ESMTPSA id me3sm2779032pjb.35.2021.12.15.08.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 08:01:23 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cf505ef6fadd1ca26cdef0f65b54a250d1b280ef.1639583569.git.pabeni@redhat.com>
References:
 <cf505ef6fadd1ca26cdef0f65b54a250d1b280ef.1639583569.git.pabeni@redhat.com>
Subject: Re: mptcp: avoid atomic bit manipulation when possible: Build
 Failure
Message-ID: <7526247f-e675-a772-1cdf-c25de6fc7fa5@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Dec 2021 16:01:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://patchwork.kernel.=
org/project/mptcp/patch/cf505ef6fadd1ca26cdef0f65b54a250d1b280ef.1639583569=
.git.pabeni@redhat.com/
  https://github.com/multipath-tcp/mptcp_net-next/a=
ctions/runs/1583525403

Status: failure
Initiator: MPTCPimporter
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/7fd994e340=
8c

Feel free to reply to this email if you cannot access logs, if you need
some support to fix the error, if this doesn't seem to be caused by your
modifications or if the error is a false positive one.

Cheers,
MPTCP GH Action bot
