Received: from mail-io1-f68.google.com (mail-io1-f68.google.com [209.85.166.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0833A2C80
	for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 17:53:24 +0000 (UTC)
Received: by mail-io1-f68.google.com with SMTP id z69so1632895iof.9
        for <mptcp@lists.linux.dev>; Thu, 14 Oct 2021 10:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=f68ZSqMXkucF3xoEdVOR1QI8AJ3sLK9WMnDTiCbagO0=;
        b=c890a+tdrPIanXicTeqbe+AK0hVKmwb0VsdcNzTISxpJbN2w91km73oWqXrBIFEE3n
         LuMWnqrXiV/JwoI0lrH3cEJ04K6Tkrc8SlS/VBJSF0OZyhCBZY1eLmNlT1lIPEMGFEOR
         XAtHozcsyx6RC5kj7rDIgPsMwIA/WZF2C5HzBvdHFhsDQOU83NE02Qt1JzPR3SRMhx0g
         e5OFd+xq8M0TWqnNJ4PsuwdV45SEbt7Ihq99lKG4qZ9Sb3XKgVnDsx94THn2P5F6nqIx
         XWes9CVhZAeqqUMyX/mbH2vGxk8//Z+COnfqKyNpXqWX3dM+YoYhy3xTlXwknQ782bCy
         2IWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=f68ZSqMXkucF3xoEdVOR1QI8AJ3sLK9WMnDTiCbagO0=;
        b=7FG0YymIQkBq1VUOeEQYcjdWEGuwF+d7QQUcUjzWpdJO4f7dOGNiqba28XomuPavZz
         gQMD4s4g6JiI5vY5LzcAss/ZnZuRlug0EBfEhUkqgn0rttT7u/Y9nv2nnQts+uEBEwZm
         CUbO1PNG7VZv9HzezudZAXu6LEAiwWIkHmP44KrgJsrU1yKvkTXOuoAwmZwlnfHBKb8q
         Hg5nk/uuUcLegofssP51c6WJNgm+A2u7KHgyT5x2UVzhe0j7N/VpRGqlVIHUGqxMqryt
         YFwRhgTQOFG0WbnzVBz8M1mqdP/uIp5tudV3iDEgeG981uy2ih+P2Ov4FpbOr8HBMIcL
         M/cg==
X-Gm-Message-State: AOAM531PPf1lYmEJjo2klqqsD3CYJ2yTHitGF+G8dcQyN6K22GMHGEee
	T+firDoafMvc7KBhWbleguEGiiMqxgBvMvM=
X-Google-Smtp-Source: ABdhPJxvutJcgNbIsurFkG4wS31darHAtbtS3IdAfj7c4GsAzkZ+YIyj50/ElOZGnVLfy4nCtjhS7A==
X-Received: by 2002:a02:6987:: with SMTP id e129mr5146332jac.136.1634234003992;
        Thu, 14 Oct 2021 10:53:23 -0700 (PDT)
Received: from [127.0.0.1] ([52.173.188.45])
        by smtp.gmail.com with ESMTPSA id q205sm1524134ioq.41.2021.10.14.10.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 10:53:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
References:
 <cf3710062ecac93e469306b3ed59a70688d36620.1633451893.git.pabeni@redhat.com>
Subject: Re: mptcp: allocate fwd memory separatelly on the rx and tx path:
 Tests Results
Message-ID: <b105b411-1c0e-719e-00a0-9debbab19c14@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Oct 2021 17:53:22 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo Abeni,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Unstable: 2 failed test(s): selftest_mptcp_join =
selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/4843090516115456
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/4843090516115456/summary/summary.txt

- KVM Validation: debug: Unstable: 3 failed test(s): selftest_diag =
selftest_mptcp_join selftest_simult_flows =F0=9F=94=B4:
  - Task: https://cirrus-ci.com/task/5968990422958080
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5968990422958080/su=
mmary/summary.txt

Initiator: ghost
Ref: patchew/cf3710062ecac93e469306b3ed=
59a70688d36620.1633451893.git.pabeni@redhat.com
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/patchew/cf3710062ecac93e469306b3ed=
59a70688d36620.1633451893.git.pabeni@redhat.com
Tree: https://github.=
com/multipath-tcp/mptcp_net-next/tree/patchew/cf3710062ecac93e469306b3ed59a=
70688d36620.1633451893.git.pabeni@redhat.com

Please note that some efforts=
 might still be needed to stabilise the tests
suite when ran on a public CI=
 like here. It is then possible some reported
issues are not due to your =
modifications. Do not hesitate to help us
improving that ;-)

Cheers,
MPTCP GH Action bot
