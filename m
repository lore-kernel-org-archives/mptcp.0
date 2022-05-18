Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453BB1852
	for <mptcp@lists.linux.dev>; Wed, 18 May 2022 06:33:46 +0000 (UTC)
Received: by mail-pj1-f53.google.com with SMTP id f10so1076191pjs.3
        for <mptcp@lists.linux.dev>; Tue, 17 May 2022 23:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b+49Xsw68uMYUzN6K6cl9M4lEMMgv1+gt6MoL57MJlw=;
        b=U3VyASclF+t2Sq7rKb7kNg32Mzk1t0rvkK9V9fB60koWLU1Fk6fcYigZLIxAYl04qV
         QMxEQYT4ezs/94ML+x59FgNHD8kBMYBfBW/kjhtyho3vW+FyT34Mqxa1txCa3jLtGThV
         +R/ZR3Pr3bP8JntaFmZs4QL9nLNWJtFOPT3kPT399HUWP/faVjXXG3r1W6Fw1D/0glt3
         XTuyfRRc5XxJI430zYcrDWIvHOmdrSO+5a7SGPFzvyNDusCM2r8/VlXfCw93dR8fu+S7
         AE3XVoFicYJV5HHzyhdELI3kPwG8l5GyXkHs0GGkzftMLKIV8OzYxGtIsmheqwFHh4kL
         DrMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b+49Xsw68uMYUzN6K6cl9M4lEMMgv1+gt6MoL57MJlw=;
        b=dLK1ndxcoyWDup2z2KeBcNxdbAqcBdNrJGOz3PmDg6ROrlMeNmEkjcgHr9CzE5edX5
         kBoZIhg8tyOcyG7fB3PfeMshLjhgZp83PBzhlq7HnQVbUYF+fgvbKy+PDeNdUHZtpqJ/
         OP7mcMvgUA/S9FlNAO/AypVJxpagxikoxuHds7lCzZBEvt5UtriTOB2z9GWRzUTPpOYB
         JS2aEV1iDasMLoED79frdyTcigdMk6EMFq/mtYMVnZsaYPmbw+bOUlbYXsEcnDr8wx8I
         dqe9vbS+eFgNVHphOmoYEmIoFA34OoSg0LjybCSokeLJcgGNLW4b1nP9sg+6yEIx+vyY
         WQrA==
X-Gm-Message-State: AOAM530+jvu8M0O1iaqkMTgQcAOqCup/0lVrZfqAVd2MNuaxn+zgMAQO
	xCjbYTE1e1jXxHnZGnPVkgH7wlqWjflGte5BDmMDOHlmxXY=
X-Google-Smtp-Source: ABdhPJzye4eHFGup5KVN9n9adPIGsaZTqj1L3JwS1ERCVKpPYowsbUORwMWrJ28t93ePY5FRiZSPoAOMSahxOv8niBU=
X-Received: by 2002:a17:90b:384d:b0:1dc:a631:e356 with SMTP id
 nl13-20020a17090b384d00b001dca631e356mr39698042pjb.82.1652855625789; Tue, 17
 May 2022 23:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1652853898.git.geliang.tang@suse.com> <b06c5cd73cb6f6bd8c57cd1b23c95ca365b30708.1652853898.git.geliang.tang@suse.com>
In-Reply-To: <b06c5cd73cb6f6bd8c57cd1b23c95ca365b30708.1652853898.git.geliang.tang@suse.com>
From: Geliang Tang <geliangtang@gmail.com>
Date: Wed, 18 May 2022 14:33:48 +0800
Message-ID: <CA+WQbwuoOP70J=20pk3dv4srFfArDM4xMOCG4J-fN=K3+nwfjw@mail.gmail.com>
Subject: Re: [PATCH mptcp-next 02/17] mptcp: move mptcp_subflow_context in net/mptcp.h
To: Geliang Tang <geliang.tang@suse.com>
Cc: MPTCP Upstream <mptcp@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

Please update the subject:

'''
mptcp: move mptcp_subflow_context to net/mptcp.h
'''
