Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA3D160
	for <mptcp@lists.linux.dev>; Sat, 19 Mar 2022 18:54:56 +0000 (UTC)
Received: by mail-lf1-f50.google.com with SMTP id t25so18838776lfg.7
        for <mptcp@lists.linux.dev>; Sat, 19 Mar 2022 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley-edu.20210112.gappssmtp.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=milPn35MHrNGWtSpKP8bSkKAA45QmEPtwWg3WxSHmiY=;
        b=K0mKi1WrSWgcF2tI97Q97Qo57ZyIV+eWb+M3EdJ2iyW6r36Du09GximlwiVu/tqxCQ
         m1zGIgrblz4J7LawxSyNIUqsfPgRtQfDIjdG47Dhwmef+m2o/vooAiF3N4SLQeXC8mRP
         2SaSpEpzwv+c5HYGWSDhWQ2O5WR7FAYiI18ZzOYTlBCRUX+ceXYpXhbLdGhf+oEfyw4W
         ftjUZIHyrV3Wzyhs1ZpcWwv9AXcjyfltkQW27pz3YoRt6LhjbPq65HiQibqVAqTx61Vi
         CaeiJTCL0fYmf8AJ/MA2DOp95eg71k3v5+/9t5LIj45pnaNcVcapc1piVQf5RAJr9eB7
         givA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=milPn35MHrNGWtSpKP8bSkKAA45QmEPtwWg3WxSHmiY=;
        b=vMFwVrG+1LcwqbmlkojMQUVRjLG3iMcSXPZjhhIiO8cvbdYQGB06g8haWZ2FI8JI+N
         dlcEj08Hq6AAa9YdPYwXgfee0jNkv8RT8obRCpPE8KCzkS8bC1vMdQ4pX2/mhDUeaGbZ
         b9N0wC00JCcgz9U3yJUM7k4pA6BozCmt7luypfK87AEGh+W9hltv4rzsQfWtxF4DXKo2
         5Nzsubpn9m7tngaa4VrS7JzE099zK6DKe9bZlEtlPuNW7zZPMH73Z5KUZAbFPBR11yWQ
         kTtgAjkIumyCPjk8GWuguFZy+cbEKnfIM/OtABq+4qVjKtmmMfi4p4GqkrkV04rTE785
         TPRQ==
X-Gm-Message-State: AOAM531yfz2TcGNb7HeJt5fcN2O5bgRAzWVnXkP/oDYcpw6mqQC0XcPX
	6Mz5SpiBawLpQj6SJoUEHdUbFDUXyhOLi1vMj2RB0hUjNIomdA==
X-Google-Smtp-Source: ABdhPJyPqwYQkYEJEcS3MODm4vfsmffBLZ2OuxymO51gHV7VHSwkN3bAMb4YXCNo/zCBe+ELtMSTmrEXHSOWw9eM3Ms=
X-Received: by 2002:ac2:58f0:0:b0:44a:206c:255d with SMTP id
 v16-20020ac258f0000000b0044a206c255dmr1783574lfo.124.1647716093926; Sat, 19
 Mar 2022 11:54:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Sam Kumar <samkumar@berkeley.edu>
Date: Sat, 19 Mar 2022 11:54:42 -0700
Message-ID: <CA+5NP0kpxDU-+57tZe0V7TkcWGH5Jc8cMhck6sKA7ptz2tvbmw@mail.gmail.com>
Subject: MPTCP Linux Implementation
To: mptcp@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello MPTCP Linux Developers,
I'm Sam Kumar, a PhD student in Computer Science at UC Berkeley. I
read the NSDI 2011 paper about congestion control in MPTCP (this
paper: https://www.usenix.org/conference/nsdi11/design-implementation-and-evaluation-congestion-control-multipath-tcp).
I think it is really nice work and I would like to try running it.

I came across your community's work on upstreaming Multipath TCP
(https://github.com/multipath-tcp/mptcp_net-next/wiki), and I wanted
to ask about the congestion control algorithm that your implementation
supports. Does the version of Multipath TCP in Linux support the
congestion control protocols for preferring subflows with less packet
loss, such as the COUPLED, SEMICOUPLED, or MPTCP (Sec. 2.5) algorithms
described in the paper? If it is different from what's described in
the paper, I'd appreciate any pointers to resources describing how the
upstream Linux implementation splits traffic across the subflows.

In case it affects the answer, I'm on Linux 5.13. I'm happy to use a
more recent kernel version if newer kernels support these congestion
control algorithms.

I'm also aware of the MPTCPv0 work
(https://github.com/multipath-tcp/mptcp_net-next/wiki) --- are the
congestion control protocols supported by that work any different?

-Sam
