Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20BC7B
	for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 13:00:51 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id p18so18453529plr.8
        for <mptcp@lists.linux.dev>; Thu, 25 Aug 2022 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc;
        bh=s9iDEn64kxWsz+UisgkRNQEd0sNXQCz8va3nbx17PqM=;
        b=OXIgMf52zQu5DN8uO3IBPsdeNCxp1fFK2XYNPlQH8zDgynaRviuffHEnxZrrx8ZDhf
         DlPh6PTRWV18+SNOp/i5Q1guTEC/tOxT58Ztv74iugtaTi9p+m3Jj/5jRaPN1B4vKS+0
         jORO2fFIp8PIJ5CsPaN8WZJ4jc5PaOVlg5VrzMjycgyPBRIGX7kFlU3lti1z+3a5R3aV
         rpeufU7SiIbwQtWYVHXFo6LMHriWsFV1Q3EMOtaYKMnSSX5PRm71gvc4xLwGoDk0Yf44
         xkjO6zJ7xYN9CTzQbR+RSLc8zViUZW224KHDn+yIZmvh1aJHrXiN3YynH3gb3ExOwP6g
         azQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc;
        bh=s9iDEn64kxWsz+UisgkRNQEd0sNXQCz8va3nbx17PqM=;
        b=4Mx+fTtMDmOUMAWPW0oLh6i7zGY1pWPsgWO972lvdZzodrAkHGQ66dHjp1E0cG/8oQ
         VpO9lDWO9NUO/dGg+rpixwAC74AbFGZziX2pJ6K096kGRHykSqxL2hVVpCcHvEMI5rc7
         Tqyvzd9krKk8fBlcc2Dgpvej319c7IHgEYRZmziwmnuugbaBcIRl91nxhGoER5UDj/st
         ZZX+yDIevlVygQOTGdCzV7LNREmhkMw2IRJWG7sOOnlc5dHpWBye69DSdFjaV33G3lTX
         mV8yoaODEMX+z3Xp80AEJE1qxvyD0EAixeN7RuL0ttgj1VXVqrQLFPKZ+f9NqY58J4Sk
         isqw==
X-Gm-Message-State: ACgBeo3ZEiCn7uAgrAbaW9c/xMHiIYlFg8aLhCHIVTbcQQbIXiMNbXZ3
	ltzkMJ/4CPlXixz0IOA3ig==
X-Google-Smtp-Source: AA6agR5lr5Js/7rz6jFUkPkxusby5Q809cd8Ycj5T3Y6jgNmhNFl5wFhal9WjgklktoyHj6dLUZA2w==
X-Received: by 2002:a17:902:c945:b0:16d:d425:324a with SMTP id i5-20020a170902c94500b0016dd425324amr3645412pla.7.1661432451334;
        Thu, 25 Aug 2022 06:00:51 -0700 (PDT)
Received: from [127.0.0.1] ([20.253.175.112])
        by smtp.gmail.com with ESMTPSA id pc9-20020a17090b3b8900b001fb6f450a9dsm3543873pjb.8.2022.08.25.06.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 06:00:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com>
References:
 <e07e982885b904607d42e1e45840c4eb3c124d4b.1661426770.git.pabeni@redhat.com>
Subject: Re: mptcp: fix fwd memory accounting on coalesce: Tests Results
Message-ID: <51990e15-1c35-cb6e-c670-9b2fad4713d1@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Aug 2022 13:00:50 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Paolo,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6639699153387520
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6639699153387520/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/4599005572235264
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4599005572235264/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/80065c141cc7


If there are some issues, you can reproduce=
 them using the same environment as
the one used by the CI thanks to a =
docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v =
"${PWD}:${PWD}:rw" -w "${PWD}" --privileged --rm -it \
        --pull always mptcp/mptcp-upstream-virtme-docker:latest \
        auto-debug

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
Bot operated by Matthieu Baerts (Tessares)
