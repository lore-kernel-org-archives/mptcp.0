Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFCC8472
	for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 23:31:17 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id g7so1267150qts.1
        for <mptcp@lists.linux.dev>; Tue, 13 Dec 2022 15:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TONXGJtT8iCJkL2jD+8CR/Ct/MWiHU8dPQ/qsXsaz3k=;
        b=Z90N2EvWw3eIlIXZhydy7af0+ViG0ciz79TwSiMel06gi3KW8B87b56ohX1zW/JWAM
         v+60Fj5/qK81g1NVedkyQ+kgliJ/A+eZS3MAo9TGPZ5kLkCa3ytSUYsUlV8WqK5ou0Jx
         CPjDXkpjZJNGh5ecXfYTWX+0N4yCznD9ahUgLxwrdHM/gEnaXQuWqFZNIZ3nLoWPpUjv
         wZxOXYUFYG60zKWnqOBN+/fndZpXeQc/uZv7LaKH25M0GXPl2+S7ZTUR5/LU26Zt8pg5
         mh7IE0VRlC9C8JAgS0lGdprIeJm8BjuK7QnK82eNoRGdN/t4d04LzsdzUXGz9dWnPrUc
         /CQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TONXGJtT8iCJkL2jD+8CR/Ct/MWiHU8dPQ/qsXsaz3k=;
        b=Q7PP6BHmXpin80SW9s8n3PF8EhDyU1Bodwj2KDJ4/IGoRcBFRWNkftKig3gMZMn+GK
         2aidZsVOBc8hTdl+UGOvmu/0HkM7C2RKxz8f3bQFzQwRXK0iIfwSOBcdyxb3S5keKoS7
         G2q3+uTtXKiZIYM5NvJ87JVRP3zoSpP74ecwUjTooBYbBkd82PvTbTafRKV4ckDZXzHm
         PpCrn82rzuVYeVX1G1IRM1HZkn4RX0jExkqs+WBxIuY6TsRJjjXsk04VuxxF+cZS6xOZ
         AWcrR9Tnrym2puQijdmwNhYZyMF/ODEl3V5d7WeB0C9mb8zjM1UHNxeuaCRslVncnT2Q
         fxXg==
X-Gm-Message-State: ANoB5pkNGellNfXpSppT71s3n4JnD1bWGTkgmon2wp6SRq9X5KJLqKGZ
	gaiBBDDbjMRHoagp4CdAvA==
X-Google-Smtp-Source: AA0mqf4qVMgSPlb/np2LfmvA7sVLvsDyi1W5IoxaOU8mKrlxkMfoYW+34FvAOMK5iotkRlLfUqD4RA==
X-Received: by 2002:ac8:4a8a:0:b0:3a5:784b:d512 with SMTP id l10-20020ac84a8a000000b003a5784bd512mr8065130qtq.40.1670974276916;
        Tue, 13 Dec 2022 15:31:16 -0800 (PST)
Received: from [127.0.0.1] ([20.14.173.22])
        by smtp.gmail.com with ESMTPSA id d18-20020ac847d2000000b003a54a19c550sm707170qtr.57.2022.12.13.15.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Dec 2022 15:31:16 -0800 (PST)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <0802393e224df13d9ac71e5fe7524e40d262b8b5.1670575887.git.geliang.tang@suse.com>
References:
 <0802393e224df13d9ac71e5fe7524e40d262b8b5.1670575887.git.geliang.tang@suse.com>
Subject: Re: mptcp: use local variable ssk in write_options: Tests Results
Message-ID: <2dd94bb0-0017-0a6c-2576-345c4ab74c10@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Dec 2022 23:31:15 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5564318373117952
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5564318373117952/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/5669871489384448
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5669871489384448/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/4543971582541824
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4543971582541824/summary/summary.txt

- KVM Validation: Script error! =E2=9D=93:
  - :
  - Task: =
https://cirrus-ci.com/task/6690218279960576
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6690218279960576/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/ab729ffde0c0


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
