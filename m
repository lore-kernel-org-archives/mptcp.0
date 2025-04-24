Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A66127B517
	for <mptcp@lists.linux.dev>; Thu, 24 Apr 2025 12:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745499496; cv=none; b=jLq7zUO7ITspXDVXnyvVRR+sshCV+8CnEKA1udJ6pG3oOP9Io0IRVllNqKtbPYbU45WdzI/Z5jBDMO9dt2lLEPKRITmSBGn2qzONRx+u12J4d3LL5/dAna1Vsx4yQKmhCR13B04hq9pMmRsdGjnzj39/JFRFmAjDzy+OyD6naXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745499496; c=relaxed/simple;
	bh=upqTTfFiSQWb/ZrTdhJkPJxbbfQ/EZ9iAHQ941JqH6Y=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=ANNXKbZp6mS8Vi1xkg4ZQ08MqXzCthzIK4j/7YBfKq+MoIO4DP9u9W5PoWIx4oS/xg0S6QPfkKX9BsOoXLIpA0FrlzNcGuTGfSlRZf64bUIdMWUz/h8qwOE12Mrdug/ik/IbFC24mISKdBEe3+SysCXoYETibKdFN4DvRSE9pIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jaRYAm0I; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jaRYAm0I"
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-47663aeff1bso9674871cf.0
        for <mptcp@lists.linux.dev>; Thu, 24 Apr 2025 05:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745499494; x=1746104294; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G1+MnjkacwNa2xrsHDQMszhOtqfobZw5MtWwKp4QytA=;
        b=jaRYAm0I9sQTnxfZap7grcpAy8uPyvaokNTJA7gopQffQWq+un5z4NAaiaOZja8JZK
         ey/L+bCfXDthhuB/40iSfLK+YMqj0XfJ9dM6JiIV39xMr2I/lSonDJxSf/J4a08BjzIW
         5+3qENwLbtcwy/XOfK975hrVX9cDS52xqz+AtqdqSbN97DkkmjPqm8IkexptvNfRm9rR
         f+mvAViwBuMWvEZTbSua7DfCBVraik1oCC76zEAbrrtg8XnZCXnIua0Yw0FnMfTm2XX9
         qUhQC5vKbDV9c3tqMguZNOmKnhwX/PzLDRE7jFRd9ziUNqSNbw6WToyQNW6Zy8O9HTJ2
         c3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745499494; x=1746104294;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G1+MnjkacwNa2xrsHDQMszhOtqfobZw5MtWwKp4QytA=;
        b=Do52Reexp2qcMDS6rYHRIbP+BEVjBoo0GE1E2ZFBxpMv4S2A2jEpckMOrm7sNiUrKI
         d3JM8uUZpNEe5OVlQMa/kNFSl8xHj8Aq92nwWCHeg5vu65xtioyI/nQmw4jqb7B+XuwH
         IwKZzmfryDAoRKNGVgRMLAiazIIgk7Q3haoDJdRQqFCpxtwEPF7cCmjz68CPPMkyjWvk
         TZnROXxR8ndxgJnxm38NUrEPQfqrerY/nhqW2iQ5jsG1T3GTFsP7HAXkyEEjDmEbKSwh
         ieHqSLVQTs0kA18vF+Tzh45XXkE85qYMb6nCg4n4JtXeaf/nMPlSap+zzqA9bZSFjH3f
         nMag==
X-Gm-Message-State: AOJu0YxLqrgVXE+zl+H+Ekz5KQK8Z5ijI+Jh9yArChNSjLRmqWllQFox
	cJHjA3OzCRaHhFKLYcC1GDCATs17jpI+CeuxUDnpsmzM40zwSg2ziex5
X-Gm-Gg: ASbGncvUjhy5G3HlPGkG2R/1PyDqmBaV9Y/BlYMSVQwRjmWwL0UKA6vf+0EM/xYc3qO
	DN4VHAhjWogRKxv6rO7wemjloir2fswBi3EImzWTbHS7sIbE7B6K09+sUb6KUgT/ODnlOOaSYhn
	61eGaxP39FiSMBxFs3aOyUiEckihKi04bRuoRMFVtc6es+qIOPLjQR4d0nLqaF10SyzAt8TDEAM
	luLnh/FnBnocNy4WHRoKffZ8M2OSJJwh0HojVoP4oJCzwm1oNQ+Sjzov6PSTpdJrUPb0e/1Dq0f
	z01EnPl3baGYlI/YUc1JQSuAZkIFTFY7dRlInDOjwi9mCQZ+098v/sN1
X-Google-Smtp-Source: AGHT+IFjs9R0xDSu75QJVOoGgkWY6jLQtPF1xhJGDXuKcMAHiKpZAGBYvIo928JmyicxAUHDwi92Sg==
X-Received: by 2002:a05:622a:1347:b0:476:fdf6:18ce with SMTP id d75a77b69052e-47eb33a7cc5mr36944231cf.30.1745499493784;
        Thu, 24 Apr 2025 05:58:13 -0700 (PDT)
Received: from [127.0.0.1] ([172.183.111.186])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47e9eaf264dsm11339981cf.10.2025.04.24.05.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 05:58:13 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <2fffe8798ad6d171110d5677b02579dab9f4cecc.1745478757.git.tanggeliang@kylinos.cn>
References:
 <2fffe8798ad6d171110d5677b02579dab9f4cecc.1745478757.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next] mptcp: sockopt: drop redundant
 tcp_getsockopt
Message-ID: <09c51718-4527-bfab-f879-32ba76085da6@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Apr 2025 12:58:12 +0000
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
- KVM Validation: btf-normal (only bpftest_all): Success=
! =E2=9C=85
- KVM Validation: btf-debug (only bpftest_all): Success! =
=E2=9C=85
- Task: https://github.com/multipath-tcp/mptcp_net-next/actions/r=
uns/14639391824

Initiator: Patchew Applier
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/ece539c873cb
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D956476


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
