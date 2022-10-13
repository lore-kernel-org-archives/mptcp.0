Received: from mail-il1-f169.google.com (mail-il1-f169.google.com [209.85.166.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F67443B
	for <mptcp@lists.linux.dev>; Thu, 13 Oct 2022 23:30:40 +0000 (UTC)
Received: by mail-il1-f169.google.com with SMTP id u10so1766653ilm.5
        for <mptcp@lists.linux.dev>; Thu, 13 Oct 2022 16:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cYh5yv5c6uB+VYxevKXk+jj8SrynmUCiS8stBc3aIMQ=;
        b=R8AAgH/6RB2XyFUqDfQYBh6bYcZ4vKRxTHXSj/gz164OswyOCpGOqRML4h9XLhncef
         iKOknlK/shfhavbQIDjpMsZG+jjesL4bmXHMCNMrf6aRhszBvQgZcyjNyeW33+8EbdoF
         p1r6LSt+MogVGM+xAL0PslUS/mX2DlNYRrxg0Pxyu24FoZyJe8TryNoOQZ5k0iRE/9Ne
         dppiSUMxfuuxLIpTf1cVzwOw7fWjEpfpABY9QuMfsA7CuTAKqVv0s2grbKa+UeICpX6G
         dPd7S0VDcuK5A5pBbdyJQE4XZHbDlzaNxYe5y77azFpUK/85/NC5RThX51gblfomgQ36
         8psg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cYh5yv5c6uB+VYxevKXk+jj8SrynmUCiS8stBc3aIMQ=;
        b=I79wv4/IsISN6zjdtpni94HQsK3tIuXaRmBsLrRDX2L9dGie+KI7/E4Igtrgm7uPsm
         jAHNWIHj6fCd2vGM3tvwBgnlQA5bkrPf46Xb9tLZz3wPJ359CruRGX3GSpuu/j6u2X4u
         q3pQsEj/XsZW+ExWUl8rF7Wd0E5SY9ZQbPjbpAwMotk1awWyvhjMZRk2EnOk+Fkphk/B
         j0fhGlo2p1tCgwMacXQlKWzvMp7SkoiaBDq3pTL3DXGG5B89cFdHO6LyFfJW+pNBfKLL
         9gQurRaJgJ1advhnVJpkS+CJAnZOcYS0EdkIa53pQstbGWNqDjkLwU5GizSwOEediYhx
         DwfQ==
X-Gm-Message-State: ACrzQf3BByWWV8eQ+DBm6ZwEJpZSBZEFSh0TI7VWq9hlYqvqZVxsRUWs
	d95MWtHWB8IeEuXwnfMvDQ==
X-Google-Smtp-Source: AMsMyM7BralF6+xiTP4I6wWvEJtIsvwxkQB1aXf+Hsx3tfEHllIT1EdVceJv70dRXU9HpK/W38GUDg==
X-Received: by 2002:a92:d28a:0:b0:2fc:1400:19c9 with SMTP id p10-20020a92d28a000000b002fc140019c9mr1206154ilp.20.1665703839536;
        Thu, 13 Oct 2022 16:30:39 -0700 (PDT)
Received: from [127.0.0.1] ([40.77.44.223])
        by smtp.gmail.com with ESMTPSA id t43-20020a05663834ab00b0035ad8fd5ce9sm475588jal.147.2022.10.13.16.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 16:30:38 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
References:
 <7c61250080c052b9dfb42a023c85dc36d4450daf.1665584136.git.pabeni@redhat.com>
Subject: Re: mptcp: fix abba deadlock on fastopen: Tests Results
Message-ID: <d3b94417-448c-131a-63c9-025973d6e992@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Oct 2022 23:30:37 +0000
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
https://cirrus-ci.com/task/5272020548583424
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5272020548583424/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/6397920455426048
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/6397920455426048/summary/summary.txt

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/0229c83c45c0


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
