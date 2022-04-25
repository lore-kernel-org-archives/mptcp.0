Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587162571
	for <mptcp@lists.linux.dev>; Mon, 25 Apr 2022 14:29:28 +0000 (UTC)
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92.3)
	(envelope-from <daniel@iogearbox.net>)
	id 1niziN-000Aea-7Z; Mon, 25 Apr 2022 16:29:23 +0200
Received: from [85.1.206.226] (helo=linux.home)
	by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <daniel@iogearbox.net>)
	id 1niziM-000VwC-UN; Mon, 25 Apr 2022 16:29:22 +0200
Subject: Re: [PATCH bpf-next 2/7] bpf: add bpf_skc_to_mptcp_sock_proto
From: Daniel Borkmann <daniel@iogearbox.net>
To: Mat Martineau <mathew.j.martineau@linux.intel.com>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: Geliang Tang <geliang.tang@suse.com>, ast@kernel.org, andrii@kernel.org,
 mptcp@lists.linux.dev, Nicolas Rybowski <nicolas.rybowski@tessares.net>,
 Matthieu Baerts <matthieu.baerts@tessares.net>
References: <20220420222459.307649-1-mathew.j.martineau@linux.intel.com>
 <20220420222459.307649-3-mathew.j.martineau@linux.intel.com>
 <903108df-161e-515b-da3d-bff4fb49de39@iogearbox.net>
Message-ID: <779c3a31-381d-75b4-5f7b-be36e9816068@iogearbox.net>
Date: Mon, 25 Apr 2022 16:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: mptcp@lists.linux.dev
List-Id: <mptcp.lists.linux.dev>
List-Subscribe: <mailto:mptcp+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:mptcp+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <903108df-161e-515b-da3d-bff4fb49de39@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.5/26523/Mon Apr 25 10:20:35 2022)

On 4/25/22 4:26 PM, Daniel Borkmann wrote:
[...]
> 
> Looking at bpf_skc_to_tcp6_sock(), do we similarly need a BTF_TYPE_EMIT() here?

(Plus, CONFIG_MPTCP should be enabled in CI config (Andrii).)

Cheers,
Daniel
