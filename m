Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F70929AE
	for <mptcp@lists.linux.dev>; Fri,  8 Apr 2022 18:44:44 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id s11so11420447qtc.3
        for <mptcp@lists.linux.dev>; Fri, 08 Apr 2022 11:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:reply-to:in-reply-to:references:subject:message-id
         :content-transfer-encoding:date:mime-version;
        bh=iQD72kx8QmrqVdbq6c6K0YIfLGL4RsDy7se5vTVa8GE=;
        b=kLOaZuUoCL0odflG+85l9mOOx0RnvmD9PIpFDvVOUBiXoANcA17dp0sD8SOwzaK66B
         MvphpkHsiPOSys1iyS5Gnxi5AHF6tOyc6FY8VBT7D6UwmRNkr+E4tRfyEwGtH37Da+8J
         ibxvzf4bepaRWhl1+8Zwt8rHOTntx3eoDxzx4fQKoFeGDD1UwN2F5jq6DWFxWZ4uL3tS
         pLJ5sfcj85Zvzwb5FYoclopYYaSpoBoOXH5x+E3FuRW7GYm0GPLi7zn5MyBxwiRHLKpa
         ny2XQ7AWJLSNXxGQsaxN+YPCbkecw43I1Mn/i5YWBxQ9uuOIbD66Xf0ICHEF1Owa71Bm
         lYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:reply-to:in-reply-to:references
         :subject:message-id:content-transfer-encoding:date:mime-version;
        bh=iQD72kx8QmrqVdbq6c6K0YIfLGL4RsDy7se5vTVa8GE=;
        b=usfpNhtgJ/N1WzDXDHMPNIO/pworcK0bYrVnp057JYmyqzzmmZAhMVth6MT9bVlgxD
         I6wGIEL039PZ/rt6gnKVXlkHcBTTuyBB9DC+e7dNJy8g2x/SwWivaaEtE8A8XU1yb0jk
         PyFgwrylDpvTJz8HNdxxdfykoJsny8lvC6jZ1HvF1vVBXABmWL+k+GZZxdhzKc/gFKQj
         Fg7J+wuq9eBwL/Xr9V53EZZ7EyUoBc4UvuXILpkriNSn8jGzvzAdfU99yRNZF0jCQGng
         4gNXZU03TEXL+zqBQHWNaiQLzoIOaKvfIWZvQ+Xm+O5j9KysnuLnFEtSsSdOlxIWNX1K
         Y/Tg==
X-Gm-Message-State: AOAM53004D9QzwyVwsvDi/V1bKZpkUdVaF6aSzXnHq1D47wQqf1KTyxQ
	9VwWNfsEVRoLmak6hrvKenBszUCCMg==
X-Google-Smtp-Source: ABdhPJyrG0ztlKcmo1bV+sxwPL+zCh6Ac6RdT8B1QbmUbG3e2DFYc1/DUVtqiRUVod0x4AgPxusctw==
X-Received: by 2002:a05:622a:1447:b0:2e1:c405:b05b with SMTP id v7-20020a05622a144700b002e1c405b05bmr17534433qtx.626.1649443483480;
        Fri, 08 Apr 2022 11:44:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.87.99.230])
        by smtp.gmail.com with ESMTPSA id f12-20020a379c0c000000b0069a048e7f0bsm3221607qke.76.2022.04.08.11.44.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 11:44:43 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <geliang.tang@suse.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <db23dee89ef9ab4ead8a731424ac283766156528.1649432004.git.geliang.tang@suse.com>
References:
 <db23dee89ef9ab4ead8a731424ac283766156528.1649432004.git.geliang.tang@suse.com>
Subject: Re: selftests: bpf: add bpf_first test: Tests Results
Message-ID: <83d1e2e3-e10f-f427-324a-3efeeba9f184@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 08 Apr 2022 18:44:42 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5710497092730880
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5710497092730880/summary/summary.txt

- {"code":404,"message":
  - "HTTP 404 Not Found"}:
  - Task: https://cirrus-ci.com/task/5559849973972992
  - Summary: https://api.cirrus-ci.com/v1/artifact/task/5559849973972992/su=
mmary/summary.txt

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/f2b773d7d369


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
Bot operated by Matthieu Baerts =
(Tessares)
