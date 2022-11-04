Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506F9AD25
	for <mptcp@lists.linux.dev>; Fri,  4 Nov 2022 20:12:34 +0000 (UTC)
Received: by mail-qk1-f177.google.com with SMTP id x18so3761771qki.4
        for <mptcp@lists.linux.dev>; Fri, 04 Nov 2022 13:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NS5YD2WHPtqq78ePjmZnNUmLaas8qwKmkIVXe5v0DLs=;
        b=cxBSSKDmgK6FSkVC8W61A9r+UAb+IuT26JvFiiojAHDfYkB86dd6TxtO1TuGFgbDKw
         VOsQYw8L3x51Rszkl/bAB6sla1irWl70Nsh3CzwwNvsM4p1aANgQAt+jkTDLIbtqwjOH
         x4nG0yn+69DHhUNPJUH0Q8Ai+oU2rjFk7Lymh+DzIOHNYx0FtFHyn22lKYBRRCrFsNM4
         /41cKiAH4wDphgv4YTkSZytcCPWT9sWlTVpWFWBhTb9wUDHn05d/VgyHbccB6jnRkLhU
         UKyyaRh004YKot90qu2Ba2Q4aqbe1jC0tsKsaPxBp45zdBwESMThAT1cubqcgAn7jS5U
         N8BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NS5YD2WHPtqq78ePjmZnNUmLaas8qwKmkIVXe5v0DLs=;
        b=5cDr7gPFzF/Xq5kmx5GgMDTIQxGNQNL9Ffnk7whKg/suTtF0GoBts7oBq2X6fV8a6+
         o0BE+2J1hq0tUH1f0SOYVjXIfzdr0f49RuMzGgGmU6PGOwvBJA8vsAkTHwdL9kguVJJa
         9kQxRKhru9Hi1tg9NkSBV1NjToV5JxjkOtkbgfl1twaRjUui1ZjcbGmaDqTllBsXq6bM
         vcT2Wc2k+99q9GUQQc1clYabUhC21YZa5eD7WWfWmMRsvHDvgfiDpE8x1lGGIJM2esK1
         T0cVTVqtflNLce/3yGW1vWmbm/rG0xFKZMHb+4sO/LK1/zUOjFGZuASM4OEFVaS7ls+e
         IMjw==
X-Gm-Message-State: ACrzQf1wJCuNLxHTihexIY9TRC12V4TBK6EHlznkgFsJfP4Ue+DlzTEg
	8Ybh7HBYKisVtuX+Rvv56N9B/iNf1Cou
X-Google-Smtp-Source: AMsMyM6vSv8Sx9ukXqIyyfu6B/UVJWen/6pu5tjM9IktWjb3r1XhWCY1Kna2rtszuoLp++5zuD363g==
X-Received: by 2002:a37:af41:0:b0:6f9:5ebe:2b10 with SMTP id y62-20020a37af41000000b006f95ebe2b10mr26423820qke.294.1667592753172;
        Fri, 04 Nov 2022 13:12:33 -0700 (PDT)
Received: from [127.0.0.1] ([20.122.88.255])
        by smtp.gmail.com with ESMTPSA id m17-20020ae9e711000000b006cfc7f9eea0sm51359qka.122.2022.11.04.13.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 13:12:32 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <d51ab9e9d73cfa3e7b8e6c8864e022d5fdad434d.1667586266.git.pabeni@redhat.com>
References:
 <d51ab9e9d73cfa3e7b8e6c8864e022d5fdad434d.1667586266.git.pabeni@redhat.com>
Subject: Re: mptcp: more detailed error reporting on endpoint creation:
 Tests Results
Message-ID: <07bbfaea-c5cd-0854-28b3-1edd3fac2e39@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Nov 2022 20:12:32 +0000
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
https://cirrus-ci.com/task/4602037861089280
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/4602037861089280/summary/summary.txt

- KVM Validation: debug:
  - Success! =E2=9C=85:
  - Task: =
https://cirrus-ci.com/task/5727937767931904
  - Summary: https://api.=
cirrus-ci.com/v1/artifact/task/5727937767931904/summary/summary.txt

Initiator: Matthieu Baerts
Commits: https://github.com/multipath-tcp/mptcp_=
net-next/commits/1b9b75524997


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
