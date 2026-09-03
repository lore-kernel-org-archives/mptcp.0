Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109C4B66CD
	for <mptcp@lists.linux.dev>; Thu,  3 Sep 2026 14:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788445308; cv=none; b=mv5Fc3Gd8QxJYLEtTJ75U3hPAIDwP/O4B2Sg+RmEya7gH+K5DalqN0m9R8em3q4LHXhyAaohuCvKmJzos5uw4rnyDVEIfIYMQrb9EnTAqzVMDnri2CapTumygEGzf0ZINAqB9trMDKAxoVBwFsALFssFIf9yVwVNzuIslERw5cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788445308; c=relaxed/simple;
	bh=uJlKQ8lK9o7lk588+UrTKx0BNHU64ji8lItBJElU44s=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-ID:Date:
	 MIME-Version:Content-Type; b=akT0hfVSb9JhC3+3sG7LDnCSeh5rpL/BDWnNrok1QVckcASdKjOzt6QjoCq/7fVVobAoG/9yisLlYyxj1iAByvbl0RfXlDpkl2EhEIU6AqTxdCbliaM0S50ekNWBp4xv1lehKfAHv/6YWUekFfAtZb+TyDcCRo7D4RBWrDzYulM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IMrq3i0V; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMrq3i0V"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-52de50e77ffso28678451cf.2
        for <mptcp@lists.linux.dev>; Thu, 03 Sep 2026 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788445302; x=1789050102; darn=lists.linux.dev;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wt22fnkJ/bjJ2L4euOdTspmYytWI72nVJ1rM7G1VT7Y=;
        b=IMrq3i0VwSxOvwyPBtM8EhBgSFuAQvJhFV+tcMfcPMMfPcWOXSHvStcINRnWvKD5hX
         Uve503IF8/3kIhzQDGlSBp+q9/OT5qfXytrojKay4dgab2d1QdGuonhnNM2YpmuJaAjl
         dsoyf3YygjFO4sxoD0FsSq2KYMGjJMlOzyEOn8QQXM/qX3b89j54U43sSODSjSgURSMH
         FtFaRA04MonOIlYiC5171RgN0VAjKYS5/7GvZU2u4gHqlzMAah1LGtI09xWi8G8CPzmw
         BaapFYQn2M/u1Aj1HBK7X+Aer8jpZmiGeHgajycWwc4svWuf0j/B6kZb/ImeV7h2C6Nh
         0Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788445302; x=1789050102;
        h=content-type:mime-version:date:content-transfer-encoding:message-id
         :subject:references:in-reply-to:reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wt22fnkJ/bjJ2L4euOdTspmYytWI72nVJ1rM7G1VT7Y=;
        b=TAy0EUJu9CgxIcyen21ONer7hNzosgD3gPVpdpnKMfgqdBhfVhcbv1of2BXnH/oZfr
         eptgLetS0boNtNh3lYgJDkGR/QeMRm1C2PFFail86zHPYKzJY6YRHF9u48ot38/0AI2U
         7ysO6JCpOQCCyBhQdD+/5A/8cOuUd6qtWxqc8me3//LOp7ir4driG4QUZTFrR5Zk2zBu
         jZS+NInetY0mwZaTomn7++xU6QasXlBpOYAi72UyLqWQ4cvcowN23hKhxuPG+C3PzFar
         RMjAXz814Xipe1bnrTrlhtxYpPnYhLQU1v4hHHb93JG5wKjtHf1jsRrDZjTo+ml9KYAX
         HZGA==
X-Gm-Message-State: AFuF++mACV3Lzyh/xeUuaALUeiipRXX0ctEp7Ll5PVC1NyyL1+5f9YTI
	GCPT8OWhXVnPyZiRqTUpYnnLj95nuxTTtb/nxZnbNirfDm9RzsbU6Sg=
X-Gm-Gg: AYBFou1/buJBVgWIwv7o+Id5ocCngdMrSO1/iUy8PeRIDWPg7ufeYiA7aXF419AG9zz
	jIgDEveYESjor2tzD2c5E+Sk16+inFdX/hQVtHkI+HSbQt3gcgVA+G2rRkVBDNGm0zrUu1rYEdG
	DapjQm77Jkg1uIEFO7o88EAIJjOKYscKpJFW8dhgXDQBE5S4u1pROkapSYBjCBXS4r1xux2cljO
	ZQ/WsXjGI9XqDRgoFdGdCqiazklNGoB0SI1t1cEd26AvH7LoayN8/t3NyS1DnofooYvcVHfvJUq
	CusfG0z1pJuOorozM7+ZwRL8QpClFbaMe8Se9WlfBWk81JTbp+yroLpY/MBzrZx0ljHLk8NlVO5
	yTOjyE7p/JEE/7A5OGiGPzIwoRXKSuCQSc0Hzn5OYc8+SD8UIEHFrICTThLmOVf9F4Xr3HvlvXh
	khhM422Biae+NTITqioQv/RDa0GEf2P+GIWYYZ/1Y0PyZrNkZyvPhcJeqp5806dRVk98fw9yY=
X-Received: by 2002:a05:622a:3c6:b0:517:9570:c1bd with SMTP id d75a77b69052e-53036cc7af7mr145684301cf.25.1788445296946;
        Thu, 03 Sep 2026 07:21:36 -0700 (PDT)
Received: from [127.0.0.1] ([20.25.10.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530331dc460sm43894431cf.18.2026.09.03.07.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 07:21:36 -0700 (PDT)
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Quanye Yang <quanyeyang@proton.me>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <20260903131416.1112393-1-cui.tao@linux.dev>
References: <20260903131416.1112393-1-cui.tao@linux.dev>
Subject: Re: [PATCH mptcp-next v2 0/3] mptcp: pm: fix reachable
 extra_subflows guards
Message-ID: <5e6167da-b5c0-3c7a-71de-a2c89cecc477@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 14:21:35 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8

Hi Quanye,

Thank you for your modifications, that's great!

Our CI did some validations and here is its report:

- KVM Validation: normal (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: normal (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (except selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: debug (only selftest_mptcp_join): Success! =E2=9C=85
- KVM Validation: btf-normal (only bpftest_all): Success! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =E2=9C=85
- Perf:=20
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/=
runs/33761727542

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/bede3b8689b2
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?=
series=3D1157123


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
