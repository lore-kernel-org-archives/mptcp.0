Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CE216FF2B
	for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 16:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713459172; cv=none; b=Zat+LyIPHqInwK7OcAQ/zdEuhS4+RHg3/bV914CtsrNP+C8mPA7bMsLVVTgrIo7G9h/xwaf7JYUnLQt/qe76Z6ZJvKmuSzbjpRKHA+V5IrK1g+fFZiOiS3nivZdBfy9NdeTuyWMTI90FhDNjpUTeQ6o1jvzU22U75tMDQTMMi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713459172; c=relaxed/simple;
	bh=5Yu/lId23JAYzaZGxlhWU2AAKwjdlTMQltgC1CHzqo0=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=gqMjrRNjTVnw7Pk0muvW2T5Go7jX4jIPgB/uCmHipBx4uW9PPsITJ4InIOMPFPObMp9YXokFEQNk+G2xCkQB+WkVrTLrmzCqeBcm24ZWecmNB4vrM8WNvAkaa61WR3hsnQ7SMRaCQAqd920C6eyI6hnFSvJSMoDEK2AGnNB2BEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ef2lGUep; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ef2lGUep"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3c730f599abso680553b6e.0
        for <mptcp@lists.linux.dev>; Thu, 18 Apr 2024 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713459170; x=1714063970; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jN+ietqg0BtgxTH9h7UnL9VNXDR4UQzLlQOY2/9ID2k=;
        b=ef2lGUeplxelD41oxoUCYaIGsyM7FJVPIlUcPpsrTRckfHZPLeISPo5PRuwgh35/7c
         ITlZtCyoKa05o1lYe6Pp5EXokZtirj5l1FlWZgywIwu/Bblt2NH+f9BT9aMZFnzQJucS
         ZwIp2Dc4mPOI8I1btIL9riYIo1GaFJF0EIHWtBPyGdre+yo41oZDXecgkPwGuSVUEXdK
         xFftsntuq9beUqIWmwiOtNpW9Yv5udrOklfcywB3dwXQmmqFMxpLibUwyKuhKnmlpXUf
         4P0dwpEAWgKAZSNVU8Undy9TQ5Jhu6oxAAvY5fVoxpBCzASy33u94XCPB1oXne4Z0o/L
         HzdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713459170; x=1714063970;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jN+ietqg0BtgxTH9h7UnL9VNXDR4UQzLlQOY2/9ID2k=;
        b=OhKL3htgfZRcqvFWGXwm/zTZZ174ypUnchMvlHGp0liejEkHk2SOm+jZLU2oe6zXtx
         6dsIVRZ8qsl2c9j+1FK4PtteXVBYrYM8+WlWWDtCrJiqpzPbSJcxya67MHgk2LTggrtw
         GT9iD0Nzu177H+dC6rVlnJlZd1vBrIYdlOKYv7/uh04uEngg5FxJPY/3TagAQ5yXsfwt
         BPAQ9NvvUjCJNI+IbWbrHS7eZDxryF2JwmQyTG+dZfZpQgv38tlFnja12JO7Cc8LXVaq
         eFYbP0LxIOijLbIFByTy++eLTkmPAZqfcfj1xGZvqdBTljsZtCyo6enLnkn0s2uXAq0D
         BZCg==
X-Gm-Message-State: AOJu0Yy0J3Q/3KrG+8Drws68k0MXtKGU7CEBtkktucIxRN6I5RvZeO9Y
	oTnx3ndoxySAuLsfqFvFCSeY8woWMGyUm7LaHTD2P+w6qhAWMOjMIYPb
X-Google-Smtp-Source: AGHT+IH5uYbvig6moUTJ7N9pzo+eVm+UTRMq3jkwwxu/xBfOfmJpSXsvj+l5Hz7PeCMOwk/8A00WQA==
X-Received: by 2002:a05:6808:210e:b0:3c5:fba5:9a23 with SMTP id r14-20020a056808210e00b003c5fba59a23mr4642828oiw.11.1713459170512;
        Thu, 18 Apr 2024 09:52:50 -0700 (PDT)
Received: from [127.0.0.1] ([20.81.158.167])
        by smtp.gmail.com with ESMTPSA id fp29-20020a05622a509d00b004364fd7a9d9sm806765qtb.58.2024.04.18.09.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 09:52:50 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To:
 <cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn>
References:
 <cc01abb2882608ac5f719e0f7960aa2a2d9fca41.1713404174.git.tanggeliang@kylinos.cn>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH_mptcp-next=5D_Squash_to_?=
 =?UTF-8?Q?=22selftests/bpf=3A_Add_bpf=5Ffirst_sche?=
 =?UTF-8?Q?duler_=26_test=22_2?=
Message-ID: <67bd2c4b-fca3-47cc-8645-10dd7fca9e2b@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Apr 2024 16:52:49 +0000
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
uns/8741315896

Initiator: Matthieu Baerts (NGI0)
Commits: https://github.=
com/multipath-tcp/mptcp_net-next/commits/0bda5a7699a6
Patchwork: https://patchwork.kernel.org/project/mptcp/list/?series=3D845641


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
