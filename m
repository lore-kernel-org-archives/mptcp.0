Received: from out-93.mta0.migadu.com (out-93.mta0.migadu.com [91.218.175.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A78DEEA0
	for <mptcp@lists.linux.dev>; Thu,  3 Aug 2023 23:27:36 +0000 (UTC)
Message-ID: <f102f07f-63c3-bca0-47ea-e3ea4357cf1c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1691105254; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBhJZPJqRLXX01E/GzXAnYcqSPb3bajdDFf4J1LeRdc=;
	b=oHoEDIxHyqkl0uC8DGaj/6q6TFEL6qT4+NB9Z63CtnWSp9hoxiXjB99juUj+LExQ69L3TW
	T1gAdbrpUJeXci4aC2qe3alqLVwqdT8AgTRcpKPEUGTKH8d9ZnLa1HmhiBOC4ovtaNpD4U
	5Lt9t5qegtuhhz8l7MXwnEeuCoaA7Hs=
Date: Thu, 3 Aug 2023 16:27:18 -0700
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Reply-To: yonghong.song@linux.dev
Subject: Re: [PATCH bpf-next v9 3/4] selftests/bpf: Add two mptcp netns
 helpers
Content-Language: en-US
To: Geliang Tang <geliang.tang@suse.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Florent Revest <revest@chromium.org>, Brendan Jackman
 <jackmanb@chromium.org>, Matthieu Baerts <matthieu.baerts@tessares.net>,
 Mat Martineau <martineau@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 John Johansen <john.johansen@canonical.com>, Paul Moore
 <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Eric Paris <eparis@parisplace.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, mptcp@lists.linux.dev,
 apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
 selinux@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <cover.1691069778.git.geliang.tang@suse.com>
 <27d3ccd2d762023b4829ba54e16a3e11925ad75d.1691069778.git.geliang.tang@suse.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <27d3ccd2d762023b4829ba54e16a3e11925ad75d.1691069778.git.geliang.tang@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/3/23 6:41 AM, Geliang Tang wrote:
> Add two netns helpers for mptcp tests: create_netns() and
> cleanup_netns(). Use them in test_base().
> 
> These new helpers will be re-used in the following commits introducing
> new tests.
> 
> Signed-off-by: Geliang Tang <geliang.tang@suse.com>
> Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>

Acked-by: Yonghong Song <yonghong.song@linux.dev>
