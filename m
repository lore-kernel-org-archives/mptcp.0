Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD67B
	for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 17:23:50 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id c1so2277864pgk.11
        for <mptcp@lists.linux.dev>; Thu, 24 Feb 2022 09:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=cDwZu3AFUXpRaJuxUvkUbh6ugrqo2PY1D2ouzsbLgXQ=;
        b=JmzjCg9jm78s05Lb1CYI88w827gLm3GmI3Wp7BbmQnLlu8Lk5i3MrZ7+kgjTyLhMfu
         o9KD9x/EK+cuMygTpynhLigzEBr83fyz2/5U/XR+9z4g3+RYJ805p/L3yadiLsSJm+f1
         AvZ+EY4wkV17UJDdeayL28mr11qrauLH2GWvDmEI3cMTGW9ZX0/nvS7I/ALXPKFptC+y
         u+Qm67qr842lECSeT4HoMmUA+or8toFGU7sLJuH6R1azxzDLcSd1pV+YlcFb5NNX+bFs
         ebxINbmZmUHYc8zAuL25urMXlt0kR2J5WiA66HtkjMLKhiB68yKYLiaTCU43bNkYFuxX
         JpWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=cDwZu3AFUXpRaJuxUvkUbh6ugrqo2PY1D2ouzsbLgXQ=;
        b=xDGcdkds0x4eU9rdyTIkfwbt0Kio4TX2UjOv2exrfQ8/+ha5vuKcaZa9TkSDn7ft0G
         uFZeIepV0IPvECx9MktLFuQI4n2Y5MZc8DBZoKbJ0GeHbiGpU7wgTU5pKxoX+lK8ZgTt
         XC1I2dQmlU2MdhxKrDbjPo1BNtZyQ6yw8hxkxhSsQIA6/RGKtm7uRzev7mZtueR7Xx8L
         9fDnIAV0MmrvtU4XNpQ6/0rZ80ZGGLP3JPi3HtjHQqs+HIBdFwFhCLR6+L+jFexWZXEU
         pGNVZzPHojG9PrixlHLUcffnjJjbVrfe9/7WVDsX6boFVURNKCSwkHiYSJDZYSISSlsA
         8iWQ==
X-Gm-Message-State: AOAM530jZMcJcMzW2mmnaiBVQc6pEP5hNEBf/9aDTP+PwFGq3IaQu/iv
	HIw8oz4l+eWRohN032Za4zaam1lHqQ==
X-Google-Smtp-Source: ABdhPJzwTyp70xnwU9r+YKI4e3YJQ3shgmYQyazW6vzU5ZF++eJ6W4gJEy1uB8XabJ8XrCfd3kmx+g==
X-Received: by 2002:a63:114:0:b0:34d:efd0:762a with SMTP id 20-20020a630114000000b0034defd0762amr3008128pgb.71.1645723429652;
        Thu, 24 Feb 2022 09:23:49 -0800 (PST)
Received: from [127.0.0.1] ([20.98.76.170])
        by smtp.gmail.com with ESMTPSA id s11-20020a056a00194b00b004e1131f86d2sm98634pfk.8.2022.02.24.09.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 09:23:49 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Florian Westphal <fw@strlen.de>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20220224155010.23676-5-fw@strlen.de>
References: <20220224155010.23676-5-fw@strlen.de>
Subject: Re: mptcp: remove per-address listening sockets: Tests Results
Message-ID: <bac5937a-d8a3-d6ab-8275-e02348ee6717@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Feb 2022 17:23:48 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Florian,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Unstable: 1 failed test(s): =
selftest_mptcp_join =F0=9F=94=B4:
  - Task: https://cirrus-ci.=
com/task/6708418592374784
  - Summary: https://api.cirrus-ci.=
com/v1/artifact/task/6708418592374784/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5856925177872384
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5856925177872384/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/6c9d91dd089f

Please note that despite all the efforts =
that have been already done to have a
stable tests suite when executed on a=
 public CI like here, it is possible some
reported issues are not due to =
your modifications. Still, do not hesitate to
help us improve that ;-)

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu Baerts =
(Tessares)
