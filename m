Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04DB2931CB
	for <mptcp@lists.linux.dev>; Fri, 16 Oct 2026 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792118991; cv=none; b=sa9brMoVTph9egVF1Cx+KWr9l+vUKl9p4qJLreicI+BfcY5d3/5LGIQvWjveSbjxqQXZoWD4Ud6Wy9EzP1x/88dCsAUoZvRHQTk04JK6nMSpay4/qA1Swf7dBv95yvNrRck4rL+uKoCEgUPKL9EsJZgDVjxq9v8F3wAlnQ273Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792118991; c=relaxed/simple;
	bh=2/7SsHHKmlIrKJD4bR613ky12NVmcdMYK56yGqrtQ2k=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=acHQjqgqX861Gb78Cqp9+QS/XLLomDXBC/wlrtsYhNP6x/BlAHq/WfB5/tGHi0mpohlMFH9xWi6WyUiRX+XWqKPUEux/hiUVXyjCsre1E3sAjzmJpkFaVqpGY3N58KO+TD4UjHBQhipE6PTTxL5ovAJmhJ4AiZNPCR9PB+OuK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHXISuHn; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHXISuHn"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-4a6bb779d13so2357803fac.1
        for <mptcp@lists.linux.dev>; Thu, 15 Oct 2026 19:49:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792118989; x=1792723789; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fKQV22m2yCl1/L0bVJjoRk5B3cVL85isyC+rvjaKdqE=;
        b=iHXISuHnTqaCxyBTYdzTBrNDnZAPghFXl3xMhcJNMDj6Xe7t8k9j3/r84euSt9f7lt
         s4I6To4i69w/Dm868ze29pDTQaA/5Z2ndeaSOb4sVfM880TfKZ/HQ/pqt/woa14UfWAw
         8BunhMUts6CbegEavCc7Pw73fulhRIZSXb188qdYHWqoFbyyzxVVF/guopqSbpI6aVPz
         l2LROHVjwz7p0PaHOTLMQvO6qUxkhs5EyIvdFTcgcu8tDggQMaArGaPjZ6++/Ox85LZs
         v6gCXoNPaxEsqO+a1KDKulFoz816Sft6MP46VcAXGXNLelTvq4hsQB/p5VFGC8chf+mU
         aahA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792118989; x=1792723789;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fKQV22m2yCl1/L0bVJjoRk5B3cVL85isyC+rvjaKdqE=;
        b=A44hVxRt+hn1tJc2yy7Zk8HU5q1Lttv5QNyjMnorX/fVja2h48DlFBrzhCUmeetrye
         u0ABNhtzC5Kh2fVcqQYlYayTtr1aV4lxTicFIbvh4hEA0qLHg7vhrL5y+F3OEjtlEsoP
         A+7zweYQ24CMIvIfdvT0wObtd977o6rOrMnuVus+lKbAtTh4q7Oak70SiYzLhynV0Pg7
         qFOoRcOq78ks6PDy3vkPDGJDHJEOHL879eVNkQCYpRRE/AE7RCBtD3Kfuz5vWMtAnt/4
         zzFR6jeZMvAbFt7mEe1YjIlSR4kv5u/eDnZQW4Qak3HsLXbKwWmLoPlCjykZUYIW+3o5
         toQA==
X-Gm-Message-State: AFq9FYJbot15XJbH38CG4gu6VxA4bVM+DjV+IN9H63ez5us7+RW9jbfE
	rJCnV5nsLsTl20KULu2XhuDp0pg/W+MgmdoCJTXR+XDN7BivrS6YBHzjGxCP
X-Gm-Gg: AYBFou14d4/fYQOUCkv4LJAELheGmXcLeDucRZf6KF/h4IDEHw0vCKrOvqbs/1aEIZC
	/juVNy3FdtSaLu2iwo+bzX8FdXNoZSBYkJqdkbu/GnzroCRG+u9h5IKfkq9kfADs4Mp+t8vk6o1
	r4AtcetFnsq06M7MbuPD4npiDu0yiwNt2kkM2y2WEwv06Ee6LrZa1U9bpSqqB4Zb8RWrbNEC9Mw
	akKtOTYI0BEsgBOyZpxydpfoNa/hSH4pWPD8Yfma8hshr3EtOodOsYItX5hqQr1NnLC87FTO1SH
	YFtW2Sw5A7DCIjCq6V39Palcqf/YkLNRl/KZKXpiB2WfAM28L71CASGAk2szpKMlL8eJLgHR6BU
	UwSjaM60z+yR6FUQoheufUA2WB6JH0ykHCxWPC2qzbETEEqCFeVN0012i2+dC1imX/lZN8UGiX0
	7uS2Y5EJKtmz3wtzPv7GGn/kXFrlf9RHJ7g/7n7zO1dsQ6PObqBCTq0OmZ6zEuQVI3LKitUZEvd
	9GBErAaAjQ4MxQ=
X-Received: by 2002:a05:6870:1704:b0:475:a1ec:9617 with SMTP id 586e51a60fabf-4a2a89d1dd9mr16501427fac.25.1792118989428;
        Thu, 15 Oct 2026 19:49:49 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.220.242])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73b7728casm667257fac.16.2026.10.15.19.49.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 19:49:48 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1792114102.git.tanggeliang@kylinos.cn>
References: <cover.1792114102.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v2 0/2] add distinct lockdep class for MPTCP
 sockets
Message-ID: <2dcefb26-8f67-ed17-b746-b50024568957@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Oct 2026 02:49:47 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf: Success! =E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_n=
et-next/actions/runs/38837878897

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/107f77088a=
f0
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1186840


If there are some issues, you can reproduce them using =
the same environment as
the one used by the CI thanks to a docker image, e.=
g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" =
-w "${PWD}" --privileged --rm -it \
        --pull always =
mptcp/mptcp-upstream-virtme-docker:latest \
        auto-normal

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
Bot operated by Matthieu Baerts (NGI0 =
Core)
