Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774C01FBEAC
	for <mptcp@lists.linux.dev>; Mon,  7 Jul 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873848; cv=none; b=oFVehExduX5GXwVv9jm9vtMH43nu2UwSjOBLHR/CVAPpVbPjTU4OlkwBSTfX6W3dVah6QhQtkl6JAYi9O7UiWkiF7TSiHkQN0TEAdilmYQtJP+J/LP9oVkwx6G0uSY9y6ya2Mcsgw49OgF50UBSpk/ev/HzKrsuzYa2n3Hb4o3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873848; c=relaxed/simple;
	bh=ZYxGjUygBJcQ4yiJ+wkKE3jM9+pM9TOpcWA62vUym58=;
	h=Content-Type:From:To:Cc:In-Reply-To:References:Subject:Message-ID:
	 Date:MIME-Version; b=eOIHaXEBaJd4ja9tR6+8b1jt3Msy3whhtIdoW8+wL3/K7YEvK3lO3oLcbqfFN+92SqvPWt4BdIAD7rhLPW2qrwYJig6TSA7dyp8yBK3RgOtD9t8PIQViU7kr6zxw2qHD9mzxuF92IgBF30TgpJwbQIfCh8CmbcURatwA3PCuUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KufUYtbM; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KufUYtbM"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-749248d06faso2267200b3a.2
        for <mptcp@lists.linux.dev>; Mon, 07 Jul 2025 00:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751873847; x=1752478647; darn=lists.linux.dev;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U0S6o6TE/erzeUMluDtHcSZ6SIiPMVSqZIwDVAlksLk=;
        b=KufUYtbMBP0mMmysYFpkhghU80IUKprc5YjnpS3NyA4PxCRxR5TIl/F3gKoELzzzuJ
         t1//Pe9uDze+zJXzIA3EgyjnA122f8YpLS0Li/RBC9yc3NWhPJWLbqHwKOCVc80o6RY8
         hLxr1cXwvaiUhcb1MLLn6xJo8Ykl6/+yt2wlKtHMLwR7qfWtwcdYRdXTUoZG2hV9fhs+
         42MUoQMYqPq3fUNf9h6ygy1jG3BT+EscO8BanBzM3zrQil6gYXxiaF6zoXKVFNVczrJg
         eu48LACICfnvwXi77ndKj/0I8E20MMWSXph+P0FDTakD5k+sx39KPEDRyLUYFAZ8S7iM
         1rHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751873847; x=1752478647;
        h=mime-version:date:content-transfer-encoding:message-id:subject
         :references:in-reply-to:reply-to:cc:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U0S6o6TE/erzeUMluDtHcSZ6SIiPMVSqZIwDVAlksLk=;
        b=vl/uVhhk5QJe9DEdi6gxqtZNa+2YeWfAGDlWPn5l1JlxXF799Zp+Yx5tbfRM8O34Sa
         rmazrVzI1eZtAupevxFpLCBSPz0JyAWSK2I77nEBtJr56Ca2w1HGz24uSp/4xJiRFAfS
         N1+ozcNJuoYWoqS/xu1Qfq90j96Clo17lNp8vCcFtLdthsvH5waEapmG+NyDpzWhSTUA
         EZCdniHyRR/5dOlOWnDgmK5Ws/i6ntPMhScf5TDZ9KdI5f6qK59GhsK2qAraVUghX/3A
         eQYfscoVr5UbVfioDBcoArTSRKix5nzU62V0/+N43f6NNvNo0xAHjlzkDo70Ti/WGNU9
         h7qA==
X-Gm-Message-State: AOJu0YyBC8FY6efgaPSOeLjRFKKU7cR7lXyF+lw9VXSc56gq0In5AX1s
	+kP54TeQtegVnTHqLeUpvnXfDj3lMjS+/dwdD7fKbTtJD3MaKJTSgR58Zflk
X-Gm-Gg: ASbGnctj49hssZnTFG7oFQZz4+gAPWzK8i4KLBbvLnr4Myq9Pz0wJvxwtOmuZK5YvkW
	i0f3SaZdDh5yn5Sma9bKMkoBD5C6EBh0wTFYl6kdVO7sHhnloFUrwPnVh5PdxZF+uDIbuKdzCdy
	WBaZXwV7BEGvfqkKIKyrT/iVXRJGnO3xZKYe18vfd4Z3wSNY9YAs7mDsx4HWhwuy7fUdMjElEW+
	7WyVlf/qityMCczFenhqvGKjDoiNgACurokHstcbSu2L0H5p5GVL9RHwFJ6barwWwLtGB5Wg7EN
	n/YoHefxBTmUSypXqmFFomqLKcYO3hMpbuYeBzkRsSxB30KvqmT7vjEPc/ncehBwIYXJSYMhoQ=
	=
X-Google-Smtp-Source: AGHT+IF/Exu58A4MNr8QUpvafljCor+nZLB0getG5mrHPqZdDwx1kmacKnvvuhduSOrLXpc/H9tkRg==
X-Received: by 2002:a05:6a00:80c:b0:749:9c2:e154 with SMTP id d2e1a72fcca58-74cf6ef743cmr9278329b3a.4.1751873846660;
        Mon, 07 Jul 2025 00:37:26 -0700 (PDT)
Received: from [127.0.0.1] ([40.78.25.127])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce43d58a3sm8811661b3a.174.2025.07.07.00.37.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jul 2025 00:37:25 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
From: MPTCP CI <wpasupplicant.patchew@gmail.com>
To: Geliang Tang <tanggeliang@kylinos.cn>
Cc: mptcp@lists.linux.dev
Reply-To: mptcp@lists.linux.dev
In-Reply-To: <cover.1751714072.git.tanggeliang@kylinos.cn>
References: <cover.1751714072.git.tanggeliang@kylinos.cn>
Subject: Re: [PATCH mptcp-next v6 0/4] implement mptcp read_sock
Message-ID: <b235c426-fb46-534b-2774-8dd2705e5be0@gmail.com>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Jul 2025 07:37:25 +0000
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hi Geliang,

Thank you for your modifications, that's great!

But sadly, our CI spotted some issues with it when trying to build it.

You can find more details there:

  https://github.com/multipath-tcp/mptcp_=
net-next/actions/runs/16110713639

Status: failure
Initiator: Matthieu =
Baerts (NGI0)
Commits: https://github.com/multipath-tcp/mptcp_net-next/comm=
its/1ecaaa711e0c
Patchwork: https://patchwork.kernel.=
org/project/mptcp/list/?series=3D979322

Feel free to reply to this email =
if you cannot access logs, if you need
some support to fix the error, if =
this doesn't seem to be caused by your
modifications or if the error is a =
false positive one.

Cheers,
MPTCP GH Action bot
Bot operated by Matthieu =
Baerts (NGI0 Core)
