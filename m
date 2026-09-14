Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6641334DB56
	for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 19:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789412619; cv=none; b=IZjjpuQNnAjwzd5jsBjPdIJahZs6W1qWguuLB7Suuq4WD1TA9tzuXewJAM+VhZYAv9pSYB7EANUtTb1SBM62AC5kPhpxHRRlzWXPMoyII4viB90XpkCFOi4yO7jQJ35RSx5fvagd76ryf2fesbgRusYls4KRauL5aY9QbB6XLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789412619; c=relaxed/simple;
	bh=7DkxajcXjINTkgjH0BeKaMWeFJuE7UBL7IdMG6gu9Ho=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=JC0Bg4GDeYIrNmZLYSCArk4SF5f2hx8ukcIhl2pU8AH2J9HyRK2toCrFAApocJyPI8ePpKSVUYsygLeOos5tmUVd5GtHRZ3qs7wzXhG7Y0TxBvF9kMNmUUJ8aia4O3iWHMdJWOZDb+wgYZteBe2MzAkS+z1Yza1c+kAvZW04hSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltlvRBkh; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltlvRBkh"
Received: by mail-qk2-f13.google.com with SMTP id af79cd13be357-93910cadeb0so233925185a.3
        for <mptcp@lists.linux.dev>; Mon, 14 Sep 2026 12:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789412614; x=1790017414; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nhpaeu5es/FwlD4TXKW88FyZrQdtA+sltPYOzeyqvIw=;
        b=ltlvRBkhtTYlvn6lD+B5zt7Gz3vXSKvY58rl869gyjItWOllKaZ3JDP3O71JRB/gNq
         OVpa7FP+5TCGSwmMPdA5jNkcgg6qozBst3nlKOGVq1cAfatbI/94n5wq4pCOilFqQ4cj
         0XtQMPjJ6XPIZwVBEW+viuR8FFbyFjyb/KZdd8KcB9f5s8mQryYCNdQK6fU/U2pCBf9H
         REmqxkZ2QtJnZcCKFZAb1zadLCda+gLmRjkxhAXydH/Z6cQ3sRgW5bWqxWu44IND0njJ
         J/1A/5O9lx54a5zTIuvW4ySnT8NIQzZ7rAlNkUzDqh4uXWG9QGu8CAq3NDP8ekOLldpu
         u8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789412614; x=1790017414;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nhpaeu5es/FwlD4TXKW88FyZrQdtA+sltPYOzeyqvIw=;
        b=A8pQH3HQ4JVQk7JfA+fpKZdR5QDLzwh7cH2B4rsX4q/zPcWtK4DqLHgJJipD6sGSBy
         XzmuV/u5gIvtHg9qdNxrbTgirntksqMN0OPxfvtD4V5/FnyeOzW7xRBEu4bP7ZN7Ro4W
         5+R+WA5a/LUzWB6C8HyaauyBlynHYXU8Ifgv9M1tFVHJUWE7/sl13Gcvk1kEuA+fBJHo
         JYufpiIeNF5z7u5O/CR0EiBm8dodeaqbBAvyYQcmQlXP9hRFCOQu7tePBg/eeAQpaXkw
         tSP/hzbi4fye0AiCC18Ft0WbYU+ZFtqsoeUgOB7hLgbj2gYz/BxjKxiTq/JOVkMPT7XI
         9mEg==
X-Gm-Message-State: AFuF++lyORUTWmJDgfUUFcWUPmkJCJsEyAB/aVcHKx42SaUA2KZUPT6L
	r7KdLW3OB94vfY3cWUf0sJ4Aglo6RhNrgm8DwcAuSA/yE1bb5Obl4mHgTwEr
X-Gm-Gg: AYBFou3a0nkU8R0v//osBV4AlGQEi24Vc4lSc8IAVO0jDfqA5ME8ZtjJBNIpdCn5VZS
	q5ruVXC/atAiDBcQEmltrLrHTXu5eYV1aECWRQ6KjKLUk/msOA8UbVkkjLfzrWrJJD8V0wKyEYV
	LiY9pTF8aF6zITWcrUzGIxeC5FsAHC4CbFJHcUN/lhhqXjxvE3SRp8IEvwejGCJjVK8SJ0YjPPJ
	vOANJnaF+jq46lJyCSGBwtRonnWoC4CpaD+STtnOqdJ0uLKxp55TPCfkXA2ZOYR1aHbPTn9yg32
	4Hz1nbUGOzo/Qt/WigHLcwLS/ity8/Pz5YA9+/mRsCT7Cz+xl2EpfEOBcF6zVe0GD3phO0Qa3PN
	Z/deUKcNskZU4D0+sDJ3wVBvAwsI7tLTSzwx0iiyB1qitZI5LeimOeZArqjnciPLJXWNxlH2Ph2
	vDcY0PTsZVwQf88HIUsdv2iz/2Sh/IxsuRLjREUIeMqnckqLljDjF/gr6xeBkBFM/vXnXOZETMk
	439Tum15rpsEw==
X-Received: by 2002:a05:620a:268d:b0:939:fc74:b6af with SMTP id af79cd13be357-93a297772camr645302685a.11.1789412614409;
        Mon, 14 Sep 2026 12:03:34 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.97.238])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93a145386f3sm530511585a.44.2026.09.14.12.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 12:03:33 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260914-mptcp-sft-join-cap-ns2-v1-1-2f48e4c5f9eb@kernel.org>
References: <20260914-mptcp-sft-join-cap-ns2-v1-1-2f48e4c5f9eb@kernel.org>
Subject: Re: [PATCH mptcp-next] selftests: mptcp: join: capture on client
 side for test 020
Message-ID: <885ba69f-0068-2328-d348-f030160b6d6d@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 19:03:33 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Matthieu,

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
et-next/actions/runs/34878489588

Initiator: Patchew Applier
Commits: https://github.com/multipath-tcp/mptcp_net-next/commits/6b5c56b662=
ba
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1164801


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
