Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9933315DBBA
	for <mptcp@lists.linux.dev>; Mon, 27 May 2024 11:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716810456; cv=none; b=qqQEgLGFXzzI/DMPfW/ZBkxxnyNkVPsbmat5CkfU/V0hQHvrtBjXgFaew0CPX67P3o5wFERCp4C4/C3LcENioz5ZDQQB1RcmT6QcInzJP4jhpG8uG9YzPfykHhOHidzPJmyUENUHKu+01G2eTVNZFjM3n6rWMZTgoYB8k2nPIiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716810456; c=relaxed/simple;
	bh=lMMOWtSA/bBf69tEoIWVvK6m2ywObml9TI/pcS8PWoY=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=K40TIENztoC20NRnrQtzvalHjptspSXKtTnnajxIM0PtOdief+5xdlS3DESyg2utBeIB14iINtRT7yolB0wk3ueJd0/QXG2L+1WaBDhDSK9F2lSUke32DusMquDPqz53CQeiRbxlGe1qGhq6lg3enm01IfyoFxIgPaIMMX4Ycx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=esvnfZs8; arc=none smtp.client-ip=209.85.222.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="esvnfZs8"
Received: by mail-ua1-f47.google.com with SMTP id a1e0cc1a2514c-804ea25904eso659567241.1
        for <mptcp@lists.linux.dev>; Mon, 27 May 2024 04:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716810453; x=1717415253; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRJQ1seNfdIHkyEzdDy0VwaOK4qPf+plqwGi5YjbyfE=;
        b=esvnfZs8mOwbLehEzGguvySwHUsLib3FNE2Y2yCDlK+WHvjWwBCWBy6hB8QgkX1Z2X
         B/WY2/F07cjPZ4ajfAEArJUbQFVQaAWIowl8B+BYi/F59lhYhHyzZehBZmJMzOJkOiwQ
         G7HGHC7XEZHnU3PuGCrqu0p6MxEtLp9LxwDUfN1lMtU94HzvFLUDxbIZvYCpUxzXFTIV
         enMEjWnU9uNXfoHIvxr3cp2M8erbG4HnPLJZP9wdxOt/tQNmaCyrVYNEGLuQvbNg4Alu
         Ksy+a7soi4T7KGTLez1yekq9mGZxiejpcd4T087LJQbGYk2m7u/WZtx91yZ16nUgyf6d
         3iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716810453; x=1717415253;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRJQ1seNfdIHkyEzdDy0VwaOK4qPf+plqwGi5YjbyfE=;
        b=JBfl1bqMj2zRvvBBSJ+3poYTmyIDBvqrD/fLyX0qaBpD8wUHyfmGdJH4W+tJChXspW
         lJoyZF1Q2FGP2vJUSrnOQzwYRtyJXAdM1yPILQuxgtQQHmQ3H9iH6+/CiDgdyR6Q3Rci
         R56toe4w/Z/lkLpHFX7jVTP7J/PB7N6sSwYo8wBXJXWlGxA0gml9PJ3z37XXC6EBR7Uq
         Cv3EI69L4GOqBhwGuQstcJg9QV0HabOQKVw89hJaDB2m/+SASJKtfk7BQ9va6ATAN34F
         mCTpNu/NGuneIh4/fdqWTQ6GCh3L49+ifLl8UBuft6mc1w0nznp0XiMoIYJNsto3Vbh+
         qGwQ==
X-Gm-Message-State: AOJu0Yyri6aDtmX3Uvonn+sBpWWKTUZJlMPI+z4ZrRNAvowt6Uf4qPsl
	vU/V37cwFZ8nPxoDd3UXm4itOKxTcVRxdtS4h8NK0D1jxei93TPkjwG1
X-Google-Smtp-Source: AGHT+IHYpCcIwFnyIO8WG0KxLyaNbvd6wXhbD1Lng7EinUwmnch5bqell/W0XRImDzb2UKqBz4e69w==
X-Received: by 2002:a67:cb02:0:b0:47f:40f7:2b5f with SMTP id ada2fe7eead31-48a38503ef3mr9241826137.5.1716810451877;
        Mon, 27 May 2024 04:47:31 -0700 (PDT)
Received: from [127.0.0.1] ([74.249.5.236])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794abcdab0csm289363785a.59.2024.05.27.04.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:47:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
References: <20240527-selftests-net-lib-fixes-v6-0-72411ff2460e@kernel.org>
Subject: Re: [PATCH mptcp-next v6 0/9] use helpers in lib.sh and
 net_helpers.sh
Message-ID: <03c4511e-fdbe-3ca4-57a4-35db099e144a@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 May 2024 11:47:30 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal: Success! =E2=9C=85
- KVM Validation: debug: =
Success! =E2=9C=85
- KVM Validation: btf (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/9253831822

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/01b4afee398d
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D856116


If there are some issues, you can reproduce them using the same =
environment as
the one used by the CI thanks to a docker image, e.g.:

    $ cd [kernel source code]
    $ docker run -v "${PWD}:${PWD}:rw" -w =
"${PWD}" --privileged --rm -it \
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
